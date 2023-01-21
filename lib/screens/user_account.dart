import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/services/models/user.dart';
import 'package:said/services/user_service.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/utils/said_session_manager.dart';
import 'package:said/widgets/buttons/said_button.dart';
import 'package:said/widgets/dropdowns/said_dropdown.dart';
import 'package:said/widgets/misc/said_user_bar.dart';
import 'package:said/widgets/textfields/said_text_field.dart';

class UserAccountPage extends StatefulWidget {
  const UserAccountPage({Key? key, required this.authenticatedUser})
      : super(key: key);

  final Future<User> authenticatedUser;

  @override
  State<UserAccountPage> createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> {
  String _sexValue = "";
  final controllers = List.generate(3, (index) => TextEditingController());
  final sexOptions = ["Male", "Female"];

  Future<void> _saveUserToSession(User updatedUser) async {
    SaidSessionManager.storeUser(
        id: updatedUser.id!,
        username: updatedUser.username,
        email: updatedUser.email,
        firstName: updatedUser.firstName,
        lastName: updatedUser.lastName,
        sex: updatedUser.sex,
        age: updatedUser.age);
  }

  Future<void> _saveChanges() async {
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
      _saveUserToSession(updatedUser);

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
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        FutureBuilder(
            future: widget.authenticatedUser,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data!.firstName != null) {
                  var fullName = '${snapshot.data!.firstName} ${snapshot.data!.lastName}';
                  return SaidUserBar(
                    userFullName: fullName,
                  );
                } else {
                  return SaidUserBar(
                    userFullName: snapshot.data!.username,
                  );
                }
              } else {
                return const SaidUserBar(
                  userFullName: "Loading...",
                );
              }
            }),
        Text(
          AppLocalizations.of(context).accountSettings,
          style: subHeader(),
        ),
        Padding(
            padding: const EdgeInsets.all(48.0),
            child: Column(
              children: [
                FutureBuilder(
                    future: widget.authenticatedUser,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return SaidTextField(
                          placeholder: AppLocalizations.of(context).firstName,
                          text: snapshot.data!.firstName,
                          textInputType: TextInputType.name,
                          callback: (newValue, controller) {
                            setState(() {
                              controllers[0] = controller;
                            });
                          },
                        );
                      } else {
                        return SaidTextField(
                          placeholder: AppLocalizations.of(context).firstName,
                          textInputType: TextInputType.name,
                          callback: (newValue, controller) {
                            setState(() {
                              controllers[0] = controller;
                            });
                          },
                        );
                      }
                    }),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                FutureBuilder(
                    future: widget.authenticatedUser,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return SaidTextField(
                          placeholder: AppLocalizations.of(context).lastName,
                          text: snapshot.data!.lastName,
                          textInputType: TextInputType.name,
                          callback: (newValue, controller) {
                            setState(() {
                              controllers[1] = controller;
                            });
                          },
                        );
                      } else {
                        return SaidTextField(
                          placeholder: AppLocalizations.of(context).lastName,
                          textInputType: TextInputType.name,
                          callback: (newValue, controller) {
                            setState(() {
                              controllers[1] = controller;
                            });
                          },
                        );
                      }
                    }),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                FutureBuilder(
                    future: widget.authenticatedUser,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return SaidTextField(
                          placeholder: AppLocalizations.of(context).age,
                          text: snapshot.data!.age.toString(),
                          textInputType: TextInputType.name,
                          callback: (newValue, controller) {
                            setState(() {
                              controllers[2] = controller;
                            });
                          },
                        );
                      } else {
                        return SaidTextField(
                          placeholder: AppLocalizations.of(context).age,
                          textInputType: TextInputType.name,
                          callback: (newValue, controller) {
                            setState(() {
                              controllers[2] = controller;
                            });
                          },
                        );
                      }
                    }),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                FutureBuilder(
                    future: widget.authenticatedUser,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done && snapshot.data!.sex != null) {
                        return SaidDropdown(
                          placeholder: AppLocalizations.of(context).sex,
                          value: snapshot.data!.sex,
                          options: sexOptions,
                          callback: (newValue) {
                            setState(() {
                              _sexValue = newValue!;
                            });
                          },
                        );
                      } else {
                        return SaidDropdown(
                          placeholder: AppLocalizations.of(context).sex,
                          options: sexOptions,
                          callback: (newValue) {
                            setState(() {
                              _sexValue = newValue!;
                            });
                          },
                        );
                      }
                    }),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                ),
                SaidButton(
                    text: AppLocalizations.of(context).save,
                    context: context,
                    onPressed: _saveChanges)
              ],
            )),
      ],
    )));
  }
}
