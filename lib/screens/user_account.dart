import 'package:flutter/material.dart';
import 'package:said/services/models/user.dart';
import 'package:said/services/user_service.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/utils/said_session_manager.dart';
import 'package:said/widgets/said_button.dart';
import 'package:said/widgets/said_dropdown.dart';
import 'package:said/widgets/said_text_field.dart';
import 'package:said/widgets/said_user_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserAccountPage extends StatefulWidget {
  const UserAccountPage({Key? key}) : super(key: key);

  @override
  State<UserAccountPage> createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> {
  List<String> sexOptions = ["Male", "Female"];

  late User _user;

  Future<void> _loadUser() async {
    // get user id:
    int userId = await SaidSessionManager.getSessionValue('id');

    // get user from API service:
    _user = await UserService.getUser(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        FutureBuilder(future: _loadUser(), builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SaidUserBar(
              userFullName: _user.username,
            );
          } else {
            return const SaidUserBar(
              userFullName: "Unknown User",
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
                SaidTextField(
                  placeholder: AppLocalizations.of(context).firstName,
                  textInputType: TextInputType.name,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                SaidTextField(
                  placeholder: AppLocalizations.of(context).lastName,
                  textInputType: TextInputType.name,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                SaidTextField(
                  placeholder: AppLocalizations.of(context).age,
                  textInputType: const TextInputType.numberWithOptions(
                      signed: false, decimal: false),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                SaidDropdown(
                    placeholder: AppLocalizations.of(context).sex,
                    options: sexOptions),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                ),
                SaidButton(
                    text: AppLocalizations.of(context).save, context: context)
              ],
            )),
      ],
    )));
  }
}
