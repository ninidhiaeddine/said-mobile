import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/said_user_post.dart';

class UserClubPage extends StatefulWidget {
  const UserClubPage({Key? key}) : super(key: key);

  @override
  State<UserClubPage> createState() => _UserClubPageState();
}

class _UserClubPageState extends State<UserClubPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(AppLocalizations.of(context).clubPosts, style: subHeader()),
              const Padding(padding: EdgeInsets.all(8)),
              const UserPost(fullName: "Dhia Nini", postContent: "Here is my steps milestone!"),
              const Padding(padding: EdgeInsets.all(8)),
              const UserPost(fullName: "Dhia Nini", postContent: "Here is my steps milestone!"),
              const Padding(padding: EdgeInsets.all(8)),
              const UserPost(fullName: "Dhia Nini", postContent: "Here is my steps milestone!"),
            ],
          ),
        ),
      ),
    );
  }
}
