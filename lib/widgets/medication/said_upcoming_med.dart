import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SaidUpcomingMed extends StatelessWidget {
  const SaidUpcomingMed(
      {super.key, required this.medName, required this.method, required this.timeOfTaking});

  final String medName;
  final String method;
  final DateTime timeOfTaking;

  String formatDateTime(DateTime dateTime) {
    String time = DateFormat('jm').format(dateTime);
    return "At $time";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(16.0))),
      child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16))),
                          child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(Icons.medical_services_rounded,
                                  size: 30)))
                    ],
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medName,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(method,
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey))
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: [Text(formatDateTime(timeOfTaking))],
              )
            ],
          )),
    );
  }
}
