import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/screens/about_screen.dart';
import 'package:said/screens/contact_screen.dart';
import 'package:said/screens/learn_screen.dart';
import 'package:said/services/models/user.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/buttons/said_primary_button.dart';
import 'package:said/widgets/buttons/said_outlined_button.dart';
import 'package:said/widgets/misc/said_user_bar.dart';

class InfoFragment extends StatefulWidget {
  const InfoFragment({Key? key, required this.authenticatedUser})
      : super(key: key);

  final User authenticatedUser;

  @override
  State<InfoFragment> createState() => _InfoFragmentState();
}

class _InfoFragmentState extends State<InfoFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(height: 32),
        Text(
          AppLocalizations.of(context).information,
          style: subHeader(),
        ),
        Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                SaidPrimaryButton(
                  text: AppLocalizations.of(context).learnAboutCRC,
                  context: context,
                  icon: const Icon(Icons.bar_chart),
                  linkTo: const LearnScreen(),
                ),
                const SizedBox(
                  height: 32,
                ),
                SaidOutlinedButton(
                  text: AppLocalizations.of(context).about,
                  context: context,
                  icon: const Icon(Icons.info_rounded),
                  linkTo: const AboutScreen(),
                ),
                const SizedBox(
                  height: 16,
                ),
                SaidOutlinedButton(
                  text: AppLocalizations.of(context).contactUs,
                  context: context,
                  icon: const Icon(Icons.email_rounded),
                  linkTo: ContactScreen(authenticatedUser: widget.authenticatedUser,),
                )
              ],
            )),
      ],
    ));
  }
}
