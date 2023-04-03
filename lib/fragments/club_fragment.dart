import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/services/models/post.dart';
import 'package:said/services/post_service.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/misc/said_user_post.dart';

class ClubFragment extends StatefulWidget {
  const ClubFragment({Key? key}) : super(key: key);

  @override
  State<ClubFragment> createState() => _ClubFragmentState();
}

class _ClubFragmentState extends State<ClubFragment> {
  late Future<List<Post>> _posts;

  @override
  void initState() {
    super.initState();
    _posts = PostService.getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(AppLocalizations.of(context).clubPosts, style: subHeader()),
                const Padding(padding: EdgeInsets.all(8)),
                FutureBuilder(
                    future: _posts,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return Column(
                          children: snapshot.data!
                              .map((e) => SaidUserPost(
                              fullName:
                              '${e.user.firstName} ${e.user.lastName}',
                              postContent: e.postContent))
                              .toList(),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Text(AppLocalizations.of(context).loading);
                      } else {
                        return Text(AppLocalizations.of(context).noPosts);
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
