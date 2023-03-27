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
  const AccountFragment(
      {Key? key, required this.authenticatedUser, required this.onRefreshUser})
      : super(key: key);

  final User authenticatedUser;
  final Function(User) onRefreshUser;

  @override
  State<AccountFragment> createState() => _AccountFragmentState();
}

class _AccountFragmentState extends State<AccountFragment> {
  String _sexValue = "";
  final controllers = List.generate(3, (index) => TextEditingController());
  late List<String> sexOptions;

  Future<void> _saveChangesAsync() async {
    User? oldUser = await SaidSessionManager.getUser();
    var updatedUser = User(
        id: oldUser!.id,
        username: oldUser.username,
        email: oldUser.email,
        firstName: controllers[0].text.isNotEmpty ? controllers[0].text : null,
        lastName: controllers[1].text.isNotEmpty ? controllers[1].text : null,
        age: controllers[2].text.isNotEmpty
            ? int.parse(controllers[2].text)
            : null,
        sex: _sexValue.isNotEmpty ? _sexValue : null);

    // 1. make api call to update user:
    var response = await UserService.updateUser(updatedUser.id!, updatedUser);

    if (response.statusCode == 200) {
      // save user to local session storage:
      //_saveUserToSessionAsync(updatedUser);

      // check if context is ready to be used:
      if (!mounted) {
        return;
      }

      // callback to refresh user in user screen:
      widget.onRefreshUser(updatedUser);

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

  void populateTextFields() {
    controllers[0].text = widget.authenticatedUser.firstName != null
        ? widget.authenticatedUser.firstName!
        : "";
    controllers[1].text = widget.authenticatedUser.lastName != null
        ? widget.authenticatedUser.lastName!
        : "";
    controllers[2].text = widget.authenticatedUser.age != null
        ? widget.authenticatedUser.age!.toString()
        : "";
  }

  @override
  void initState() {
    super.initState();
    populateTextFields();
  }

  @override
  Widget build(BuildContext context) {
    sexOptions = [
      AppLocalizations.of(context).male,
      AppLocalizations.of(context).female
    ];
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            Builder(builder: (context) {
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
            const SizedBox(
              height: 32,
            ),
            Text(
              AppLocalizations.of(context).accountSettings,
              style: subHeader(),
            ),
            const SizedBox(
              height: 32,
            ),
            SaidTextField(
              placeholder: AppLocalizations.of(context).firstName,
              textInputType: TextInputType.name,
              controller: controllers[0],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
            ),
            SaidTextField(
              placeholder: AppLocalizations.of(context).lastName,
              textInputType: TextInputType.name,
              controller: controllers[1],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
            ),
            SaidTextField(
              placeholder: AppLocalizations.of(context).age,
              textInputType: TextInputType.name,
              controller: controllers[2],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
            ),
            SaidDropdown(
              placeholder: AppLocalizations.of(context).sex,
              options: sexOptions,
              value: widget.authenticatedUser.sex,
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
                onPressed: _saveChangesAsync),
          ],
        ),
      ),
    ));
  }
}
