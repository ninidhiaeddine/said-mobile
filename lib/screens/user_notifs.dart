import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/said_announcement.dart';

class UserNotifsPage extends StatefulWidget {
  const UserNotifsPage({Key? key}) : super(key: key);

  @override
  State<UserNotifsPage> createState() => _UserNotifsPageState();
}

class _UserNotifsPageState extends State<UserNotifsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(78, 32, 78, 16),
          child: Image(image: AssetImage('assets/images/logo.png')),
        ),
        Text(
          AppLocalizations.of(context).announcements,
          style: subHeader(),
        ),
        const Padding(
          padding: EdgeInsets.all(16),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: [
                SaidAnnouncement(
                    content: "We are hosting out Walkathon soon!",
                    dateTime: DateTime(2023, 7, 7)),
                const Padding(
                  padding: EdgeInsets.all(8),
                ),
                SaidAnnouncement(
                    content: "We are hosting out Walkathon soon!",
                    dateTime: DateTime(2023, 7, 7)),
                const Padding(
                  padding: EdgeInsets.all(8),
                ),
                SaidAnnouncement(
                    content: "We are hosting out Walkathon soon!",
                    dateTime: DateTime(2023, 7, 7)),
                const Padding(
                  padding: EdgeInsets.all(8),
                ),
              ],
            ))
      ],
    )));
  }
}
