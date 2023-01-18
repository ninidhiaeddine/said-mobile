import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:said/config/color_constants.dart';
import 'package:said/theme/text_styles.dart';

class SaidAnnouncement extends StatelessWidget {
  const SaidAnnouncement(
      {Key? key, required this.content, required this.dateTime})
      : super(key: key);

  final String content;
  final DateTime dateTime;

  String formatDateTime(DateTime dateTime) {
    var date = DateFormat.yMd().format(dateTime);
    var time = DateFormat.jm().format(dateTime);
    return "$date at $time";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            color: ColorConstants.announcementColor,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(2, 2),
                blurRadius: 3,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(content),
            const Padding(padding: EdgeInsets.all(5)),
            Align(
                alignment: Alignment.centerRight,
                child: Text(
                  formatDateTime(dateTime),
                  style: announcementDate(),
                ))
          ],
        ));
  }
}
