import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:said/config/color_constants.dart';
import 'package:said/screens/medication/edit_medication_screen.dart';
import 'package:said/services/medication_service.dart';
import 'package:said/services/models/medication.dart';
import 'package:said/services/models/user.dart';
import 'package:said/services/utils/medication_reminder_utils.dart';
import 'package:said/widgets/buttons/said_fab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SaidEditableMed extends StatelessWidget {
  const SaidEditableMed(
      {super.key,
      required this.authenticatedUser,
      required this.medication,
      required this.onRefreshScreen});

  final User authenticatedUser;
  final Medication medication;
  final Function(User) onRefreshScreen;

  Future<void> _deleteMedication(BuildContext context) async {
    // first things first, delete associated medication reminders:
    bool success = await deleteAssociatedMedicationReminders(medication);
    if (!success) {
      return;
    }

    // second, delete medication itself:
    var response = await MedicationService.deleteMedication(medication.id!);

    if (response.statusCode != 200) {
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
      onRefreshScreen(authenticatedUser);

      // show snackbar:
      final snackBar = SnackBar(
        content: Text(AppLocalizations.of(context).changesSavedSuccess),
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
          padding: const EdgeInsets.all(16),
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
                        medication.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(medication.method,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.grey)),
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
                      linkTo: EditMedicationScreen(
                        authenticatedUser: authenticatedUser,
                        onRefreshScreen: onRefreshScreen,
                        medication: medication,
                      )),
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
