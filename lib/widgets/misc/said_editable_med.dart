import 'package:flutter/material.dart';
import 'package:said/config/color_constants.dart';
import 'package:said/screens/edit_medication_page.dart';
import 'package:said/services/models/user.dart';
import 'package:said/widgets/buttons/said_fab.dart';

class SaidEditableMed extends StatefulWidget {
  const SaidEditableMed(
      {super.key,
      required this.authenticatedStudent,
      required this.medName,
      required this.method});

  final User authenticatedStudent;
  final String medName;
  final String method;

  @override
  State<SaidEditableMed> createState() => _SaidEditableMedState();
}

class _SaidEditableMedState extends State<SaidEditableMed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(16.0))),
      child: Padding(
          padding: const EdgeInsets.all(12),
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
                        widget.medName,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(widget.method,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.grey)),
                      const Padding(padding: EdgeInsets.all(8)),
                      const Text("Every Day at 9 AM",
                          style: TextStyle(color: Colors.grey))
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  SaidFab(
                      dimensions: 40,
                      backgroundColor: ColorConstants.secondaryColor,
                      icon: const Icon(Icons.edit),
                      linkTo: EditMedicationPage(
                          authenticatedUser: widget.authenticatedStudent)),
                  const Padding(padding: EdgeInsets.all(4)),
                  const SaidFab(
                      dimensions: 40,
                      backgroundColor: Colors.red,
                      icon: Icon(Icons.delete),
                      onPressed: null)
                ],
              )
            ],
          )),
    );
  }
}
