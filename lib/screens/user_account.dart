import 'package:flutter/material.dart';
import 'package:said/theme/text_styles.dart';
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
  @override
  Widget build(BuildContext context) {
    List<String> sexOptions = ["Male", "Female"];

    return Scaffold(
        body: Column(
      children: [
        const SaidUserBar(),
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
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                SaidTextField(
                  placeholder: AppLocalizations.of(context).lastName,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                SaidTextField(
                  placeholder: AppLocalizations.of(context).age,
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
    ));
  }
}
