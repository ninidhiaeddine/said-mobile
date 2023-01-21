import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/screens/about.dart';
import 'package:said/screens/contact.dart';
import 'package:said/screens/learn.dart';
import 'package:said/services/models/user.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/buttons/said_button.dart';
import 'package:said/widgets/buttons/said_outlined_button.dart';
import 'package:said/widgets/misc/said_user_bar.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key, required this.authenticatedUser}) : super(key: key);

  final User authenticatedUser;

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
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
                  linkTo: const LearnPage(),
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
