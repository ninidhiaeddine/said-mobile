import 'package:said/config/color_constants.dart';
import 'package:flutter/material.dart';

class SaidUpcomingMed extends StatelessWidget {
  const SaidUpcomingMed(
      {super.key, required this.medName, required this.method});

  final String medName;
  final String method;

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
                                  size: 40)))
                    ],
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medName,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(method,
                          style:
                              const TextStyle(fontSize: 16, color: Colors.grey))
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: [const Text("9:00")],
              )
            ],
          )),
    );
  }
}
