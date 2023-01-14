import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/said_profile_pic.dart';

class SaidUserBar extends StatefulWidget {
  const SaidUserBar({super.key, this.userFullName = "John Doe", this.meds = 0});

  final String userFullName;
  final int meds;

  @override
  State<StatefulWidget> createState() => _SaidUserBarState();
}

class _SaidUserBarState extends State<SaidUserBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          const SaidProfilePic(),
          Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context).welcome),
                    Text(widget.userFullName, style: userName()),
                  ]),
              const Spacer(),
              const IconButton(
                  iconSize: 40,
                  onPressed: null,
                  icon: Icon(Icons.circle_notifications_rounded)),
            ],
          ),
        ],
      )
    );
  }
}
