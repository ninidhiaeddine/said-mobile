import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/services/announcement_service.dart';
import 'package:said/services/models/announcement.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/misc/said_announcement.dart';

class AnnouncementsFragment extends StatefulWidget {
  const AnnouncementsFragment({Key? key}) : super(key: key);

  @override
  State<AnnouncementsFragment> createState() => _AnnouncementsFragmentState();
}

class _AnnouncementsFragmentState extends State<AnnouncementsFragment> {
  late Future<List<Announcement>> _announcements;

  @override
  void initState() {
    super.initState();
    _announcements = AnnouncementService.getAllAnnouncements();
  }

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
                  future: _announcements,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                      return ListView(
                        children: snapshot.data!
                            .map((e) => SaidAnnouncement(
                            content: e.content, createdAt: e.createdAt))
                            .toList(),
                      );
                    } else if (snapshot.connectionState == ConnectionState.waiting){
                      return Text(
                          AppLocalizations.of(context).loading);
                    } else {
                      print("No Announcements");
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
