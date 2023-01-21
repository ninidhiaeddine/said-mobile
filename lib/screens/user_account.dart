import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:said/services/models/user.dart';
import 'package:said/services/user_service.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/types/sex.dart';
import 'package:said/utils/said_session_manager.dart';
import 'package:said/widgets/buttons/said_button.dart';
import 'package:said/widgets/dropdowns/said_dropdown.dart';
import 'package:said/widgets/textfields/said_text_field.dart';
import 'package:said/widgets/misc/said_user_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserAccountPage extends StatefulWidget {
  const UserAccountPage({Key? key}) : super(key: key);

  @override
  State<UserAccountPage> createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> {
  String _sexValue = "";
  final controllers = List.generate(3, (index) => TextEditingController());
  final sexOptions = ["Male", "Female"];

  late Future<User> _user;

  Future<void> _saveChanges() async {
    var updatedUser = User(
        id: (await _user).id,
        username: (await _user).username,
        email: (await _user).email,
        firstName: controllers[0].text.isNotEmpty ? controllers[0].text : null,
        lastName: controllers[1].text.isNotEmpty ? controllers[0].text : null,
        age: controllers[2].text.isNotEmpty ? int.parse(controllers[2].text) : null,
        sex: _sexValue.isNotEmpty ? sexToEnum(_sexValue) : null);

    print(updatedUser.sex);
    var response = await UserService.updateUser(updatedUser.id!, updatedUser);

    if (response.statusCode == 200) {
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

  Future<User> _loadUser() async {
    // get user id:
    int userId = await SaidSessionManager.getSessionValue('id');

    // get user from API service:
    return UserService.getUser(userId);
  }

  @override
  void initState() {
    super.initState();
    _user = _loadUser();
  }

  @override
  Widget build(BuildContext context) {
    print("rebuilding");
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        FutureBuilder(
            future: _user,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SaidUserBar(
                  userFullName: snapshot.data!.username,
                );
              } else {
                return const SaidUserBar(
                  userFullName: "Loading",
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
                    future: _user,
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
                    future: _user,
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
                    future: _user,
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
                    future: _user,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.data!.sex != null) {
                        return SaidDropdown(
                          placeholder: AppLocalizations.of(context).sex,
                          value: sexToString(snapshot.data!.sex!),
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
