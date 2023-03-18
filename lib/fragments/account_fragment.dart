import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/services/models/user.dart';
import 'package:said/services/user_service.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/utils/said_session_manager.dart';
import 'package:said/widgets/buttons/said_primary_button.dart';
import 'package:said/widgets/dropdowns/said_dropdown.dart';
import 'package:said/widgets/misc/said_user_bar.dart';
import 'package:said/widgets/textfields/said_text_field.dart';

class AccountFragment extends StatefulWidget {
  const AccountFragment({Key? key, required this.authenticatedUser})
      : super(key: key);

  final User authenticatedUser;

  @override
  State<AccountFragment> createState() => _AccountFragmentState();
}

class _AccountFragmentState extends State<AccountFragment> {
  String _sexValue = "";
  final controllers = List.generate(3, (index) => TextEditingController());
  late List<String> sexOptions;

  Future<void> _saveUserToSessionAsync(User updatedUser) async {
    SaidSessionManager.storeUser(
        id: updatedUser.id!,
        username: updatedUser.username,
        email: updatedUser.email,
        firstName: updatedUser.firstName,
        lastName: updatedUser.lastName,
        sex: updatedUser.sex,
        age: updatedUser.age);
  }

  Future<void> _saveChangesAsync() async {
    User oldUser = await SaidSessionManager.getUser();
    var updatedUser = User(
        id: oldUser.id,
        username: oldUser.username,
        email: oldUser.email,
        firstName: controllers[0].text.isNotEmpty ? controllers[0].text : null,
        lastName: controllers[1].text.isNotEmpty ? controllers[1].text : null,
        age: controllers[2].text.isNotEmpty
            ? int.parse(controllers[2].text)
            : null,
        sex: _sexValue.isNotEmpty ? _sexValue : null);

    // 1. make api call:
    var response = await UserService.updateUser(updatedUser.id!, updatedUser);

    if (response.statusCode == 200) {
      // save user to local session storage:
      _saveUserToSessionAsync(updatedUser);

      if (!mounted) {
        return;
      }

      // show snackbar:
      final snackBar = SnackBar(
        content: Text(AppLocalizations.of(context).changesSavedSuccess),
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
            Text('${AppLocalizations.of(context).changesSavedError}: $errMsg'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    super.initState();
    sexOptions = [
      AppLocalizations.of(context).male,
      AppLocalizations.of(context).female
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Builder(builder: (context) {
            if (widget.authenticatedUser.firstName != null) {
              var fullName =
                  '${widget.authenticatedUser.firstName} ${widget.authenticatedUser.lastName}';
              return SaidUserBar(
                userFullName: fullName,
              );
            } else {
              return SaidUserBar(
                userFullName: widget.authenticatedUser.username,
              );
            }
          }),
        ),
        const Padding(padding: EdgeInsets.all(16)),
        Text(
          AppLocalizations.of(context).accountSettings,
          style: subHeader(),
        ),
        Padding(
            padding: const EdgeInsets.all(48.0),
            child: Column(
              children: [
                SaidTextField(
                  placeholder: AppLocalizations.of(context).firstName,
                  text: widget.authenticatedUser.firstName,
                  textInputType: TextInputType.name,
                  callback: (newValue, controller) {
                    setState(() {
                      controllers[0] = controller;
                    });
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                SaidTextField(
                  placeholder: AppLocalizations.of(context).lastName,
                  text: widget.authenticatedUser.lastName,
                  textInputType: TextInputType.name,
                  callback: (newValue, controller) {
                    setState(() {
                      controllers[1] = controller;
                    });
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                SaidTextField(
                  placeholder: AppLocalizations.of(context).age,
                  text: widget.authenticatedUser.age?.toString(),
                  textInputType: TextInputType.name,
                  callback: (newValue, controller) {
                    setState(() {
                      controllers[2] = controller;
                    });
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                SaidDropdown(
                  placeholder: AppLocalizations.of(context).sex,
                  value: widget.authenticatedUser.sex,
                  options: sexOptions,
                  callback: (newValue) {
                    setState(() {
                      _sexValue = newValue!;
                    });
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                ),
                SaidPrimaryButton(
                    text: AppLocalizations.of(context).save,
                    context: context,
                    onPressed: _saveChangesAsync)
              ],
            )),
      ],
    )));
  }
}
