import 'package:said/services/medication_reminder_service.dart';
import 'package:said/services/models/medication.dart';
import 'package:said/services/models/medication_reminder.dart';

Future<bool> deleteAssociatedMedicationReminders(Medication medication) async {
  // get all associated medication reminders:
  List<MedicationReminder> reminders =
      await MedicationReminderService.getAllMedicationReminders(medication.id!);

  // delete each one of them:
  for (var reminder in reminders) {
    var response =
        await MedicationReminderService.deleteMedicationReminder(reminder.id!);

    if (response.statusCode != 200) {
      return false;
    }
  }

  return true;
}
