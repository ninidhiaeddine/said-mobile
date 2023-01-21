import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/services/announcement_service.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/misc/said_announcement.dart';

class UserAnnouncementsPage extends StatefulWidget {
  const UserAnnouncementsPage({Key? key}) : super(key: key);

  @override
  State<UserAnnouncementsPage> createState() => _UserAnnouncementsPageState();
}

class _UserAnnouncementsPageState extends State<UserAnnouncementsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(32),
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
            Expanded(
              child: FutureBuilder(
                  future: AnnouncementService.getAllAnnouncements(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView(
                        children: snapshot.data!
                            .map((e) => SaidAnnouncement(
                            content: e.content, createdAt: e.createdAt))
                            .toList(),
                      );
                    } else {
                      return Text(
                          AppLocalizations.of(context).noAnnouncements);
                    }
                  }),
            )
          ],
        ),
      ),
    ));
  }
}
