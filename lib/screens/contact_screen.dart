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
import 'package:said/widgets/buttons/said_button.dart';
import 'package:said/widgets/buttons/said_icon_back_button.dart';
import 'package:said/widgets/misc/said_social_media_bar.dart';
import 'package:said/widgets/textfields//said_text_field.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late String _messageValue = "";
  late TextEditingController _controller;

  User? _user;

  Future<void> _loadUserAsync() async {
    // get user id:
    int userId = await SaidSessionManager.getSessionValue('id');
    print("Loading User Async | UserId = " + userId.toString());

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
      // empty message box:
      _controller.text = "";
      _messageValue = "";

      if (!mounted) {
        return;
      }

      // show snackbar:
      final snackBar = SnackBar(
        content: Text(AppLocalizations.of(context).messageSentSuccess),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      var body = jsonDecode(response.body);
      var errMsg = body['error']['message'];

      if (!mounted) {
        return;
      }

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
    _loadUserAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.white,
          title: Text(AppLocalizations.of(context).contactUs,
              style: subHeaderWhite()),
          centerTitle: true,
          leading: const SaidIconBackButton()),
      backgroundColor: ColorConstants.secondaryColor,
      body: SafeArea(
        child: Expanded(
          child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  SaidTextField(
                    placeholder: AppLocalizations.of(context).message,
                    linesCount: 10,
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
                  const Spacer(),
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
