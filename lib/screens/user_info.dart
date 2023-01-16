import 'package:flutter/material.dart';
import 'package:said/screens/about.dart';
import 'package:said/screens/contact.dart';
import 'package:said/screens/education.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/said_button.dart';
import 'package:said/widgets/said_outlined_button.dart';
import 'package:said/widgets/said_user_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SaidUserBar(),
        Text(
          AppLocalizations.of(context).information,
          style: subHeader(),
        ),
        Padding(
            padding: const EdgeInsets.all(48.0),
            child: Column(
              children: [
                SaidButton(
                  text: AppLocalizations.of(context).learnAboutCRC,
                  context: context,
                  icon: const Icon(Icons.bar_chart),
                  linkTo: const EducationPage(),
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                SaidOutlinedButton(
                  text: AppLocalizations.of(context).about,
                  context: context,
                  icon: const Icon(Icons.info_rounded),
                  linkTo: const AboutPage(),
                ),
                SaidOutlinedButton(
                  text: AppLocalizations.of(context).contactUs,
                  context: context,
                  icon: const Icon(Icons.email_rounded),
                  linkTo: const ContactPage(),
                )
              ],
            )),
      ],
    ));
  }
}
