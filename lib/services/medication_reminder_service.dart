import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:said/config/api_constants.dart';
import 'package:said/services/models/medication_reminder.dart';

class MedicationReminderService {
  static Future<List<MedicationReminder>> getAllMedicationReminders(int medicationId) async {
    final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.medicationRemindersEndpoint}?medication=$medicationId'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return parseMedicationReminders(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Medication Reminders');
    }
  }

  static Future<http.Response> addMedicationReminder(MedicationReminder medicationReminder) {
    return http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.medicationRemindersEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(MedicationReminder));
  }

  static Future<http.Response> deleteMedicationReminder(MedicationReminder medicationReminder) {
    return http.delete(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.medicationRemindersEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(MedicationReminder));
  }

  // helper method:
  static List<MedicationReminder> parseMedicationReminders(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return parsed.map((json) => MedicationReminder.fromJson(json)).toList();
  }
}
