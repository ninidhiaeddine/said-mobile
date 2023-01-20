import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/config/color_constants.dart';
import 'package:said/services/message_service.dart';
import 'package:said/services/models/message.dart';
import 'package:said/services/models/user.dart';
import 'package:said/services/user_service.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/utils/said_session_manager.dart';
import 'package:said/widgets/said_button.dart';
import 'package:said/widgets/said_social_media_bar.dart';
import 'package:said/widgets/said_text_field.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late String _messageValue = "";
  late TextEditingController _controller;

  User? _user;

  Future<void> _loadUser() async {
    // get user id:
    int userId = await SaidSessionManager.getSessionValue('id');

    // get user from API service:
    _user = await UserService.getUser(userId);
  }

  Future<void> _sendMessage(BuildContext context) async {
    // prepare message:
    var message =
        Message(user: _user!, message: _messageValue, dateSent: DateTime.now());

    // make api call:
    var response = await MessageService.addMessage(message);

    if (response.statusCode == 200) {
      // show snackbar:
      final snackBar = SnackBar(
        content: Text(AppLocalizations.of(context).messageSentSuccess),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // empty message box:
      _controller.text = "";
      _messageValue = "";
    } else {
      var body = jsonDecode(response.body);
      var errMsg = body['error']['message'];
      // show snackbar:
      final snackBar = SnackBar(
        content:
            Text('${AppLocalizations.of(context).messageSentError}: $errMsg'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      backgroundColor: ColorConstants.secondaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Text(AppLocalizations.of(context).contactUs,
                      style: subHeaderWhite()),
                  const Padding(padding: EdgeInsets.all(16.0)),
                  SaidTextField(
                    placeholder: AppLocalizations.of(context).message,
                    linesCount: 6,
                    blackVariant: true,
                    callback: (newValue, controller) => {
                      setState(() {
                        _messageValue = newValue;
                        _controller = controller;
                      })
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(4)),
                  SaidButton(
                    text: AppLocalizations.of(context).send,
                    context: context,
                    icon: const Icon(Icons.send),
                    enabled: _user != null,
                    onPressed: () => _sendMessage(context),
                  ),
                  const Padding(padding: EdgeInsets.all(8)),
                  Padding(
                      padding: const EdgeInsets.all(60),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_pin,
                                  color: Colors.white),
                              const Padding(padding: EdgeInsets.all(6)),
                              Text(AppLocalizations.of(context).saidLocation,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))
                            ],
                          ),
                          const Padding(padding: EdgeInsets.all(4)),
                          Row(
                            children: [
                              const Icon(Icons.phone, color: Colors.white),
                              const Padding(padding: EdgeInsets.all(6)),
                              Text(AppLocalizations.of(context).saidPhoneNumber,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))
                            ],
                          ),
                          const Padding(padding: EdgeInsets.all(4)),
                          Row(
                            children: [
                              const Icon(Icons.email_rounded,
                                  color: Colors.white),
                              const Padding(padding: EdgeInsets.all(6)),
                              Text(AppLocalizations.of(context).saidEmail,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))
                            ],
                          ),
                        ],
                      )),
                  const Padding(padding: EdgeInsets.all(2.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context).followUs,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white)),
                      const Padding(padding: EdgeInsets.all(2)),
                      Text(AppLocalizations.of(context).socialMedia,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.primaryColor)),
                    ],
                  ),
                  SaidSocialMediaBar(),
                ],
              )),
        ),
      ),
    );
  }
}
