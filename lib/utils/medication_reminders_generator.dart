import 'package:flutter/material.dart';
import 'package:said/services/models/medication_reminder.dart';
import 'package:said/services/models/medication.dart';

List<MedicationReminder> generateMedicationReminders(
    Medication medication,
    DateTime startDate,
    DateTime endDate,
    TimeOfDay timeOfTaking,
    List<bool> daysSelections) {
  var lstTargetDays = [];

  // initialize iterator:
  var iter = DateTime(startDate.year, startDate.month, startDate.day,
      timeOfTaking.hour, timeOfTaking.minute);
  while (iter.isBefore(endDate)) {
    if (daysSelections[iter.weekday - 1]) {
      lstTargetDays.add(iter);
    }

    // increment day:
    iter = iter.add(const Duration(days: 1));
  }

  var reminders = List.generate(
      lstTargetDays.length,
          (i) => MedicationReminder(
          medication: medication,
          alreadyTaken: false,
          dateTime: lstTargetDays[i]));

  return reminders;
}