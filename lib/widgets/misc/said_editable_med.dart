import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:said/config/color_constants.dart';
import 'package:said/screens/edit_medication_page.dart';
import 'package:said/services/medication_service.dart';
import 'package:said/services/models/medication.dart';
import 'package:said/services/models/user.dart';
import 'package:said/widgets/buttons/said_fab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SaidEditableMed extends StatefulWidget {
  const SaidEditableMed(
      {super.key,
      required this.authenticatedStudent,
      required this.medication});

  final User authenticatedStudent;
  final Medication medication;

  @override
  State<SaidEditableMed> createState() => _SaidEditableMedState();
}

class _SaidEditableMedState extends State<SaidEditableMed> {
  Future<void> _deleteMedication(BuildContext context) async {
    var response =
        await MedicationService.deleteMedication(widget.medication.id!);

    if (response.statusCode != 200) {
      if (!mounted) {
        return;
      }

      var body = jsonDecode(response.body);
      var errMsg = body['error']['message'];

      // show snackbar:
      final snackBar = SnackBar(
        content:
        Text('${AppLocalizations.of(context).changesSavedError}: $errMsg'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      if (!mounted) {
        return;
      }

      // show snackbar:
      final snackBar = SnackBar(
        content:
        Text(AppLocalizations.of(context).changesSavedSuccess),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

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
                        widget.medication.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(widget.medication.method,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.grey)),
                      const Padding(padding: EdgeInsets.all(8)),
                      const Text("--", style: TextStyle(color: Colors.grey))
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  // SaidFab(
                  //     dimensions: 40,
                  //     backgroundColor: ColorConstants.secondaryColor,
                  //     icon: const Icon(Icons.edit),
                  //     linkTo: EditMedicationPage(
                  //         authenticatedUser: widget.authenticatedStudent)),
                  const Padding(padding: EdgeInsets.all(4)),
                  SaidFab(
                      dimensions: 40,
                      backgroundColor: Colors.red,
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteMedication(context))
                ],
              )
            ],
          )),
    );
  }
}
