import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/said_avatar.dart';

class SaidUserBar extends StatefulWidget {
  const SaidUserBar({super.key, this.userFullName = "John Doe", this.meds = 0});

  final String userFullName;
  final int meds;

  @override
  State<StatefulWidget> createState() => _SaidUserBarState();
}

class _SaidUserBarState extends State<SaidUserBar> {
  String _extractNameInitials(String userFullName) {
    String nameInitials = "";

    var names = userFullName.toUpperCase().split(' ');
    for (var value in names) {
      if (nameInitials.length >= 2) {
        break;
      }

      nameInitials += value[0];
    }

    return nameInitials;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
      child: Column(
        children: [
          SaidAvatar(nameInitials: _extractNameInitials(widget.userFullName)),
          const Padding(padding: EdgeInsets.all(12.0)),
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
