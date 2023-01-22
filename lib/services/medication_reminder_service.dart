import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:said/config/api_constants.dart';
import 'package:said/services/models/medication_reminder.dart';
import 'package:said/utils/flatten_api_response.dart';

class MedicationReminderService {
  static Future<List<MedicationReminder>> getAllMedicationReminders(
      int medicationId) async {
    final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.medicationRemindersEndpoint}?medication=$medicationId'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['API_KEY']}'
        });

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

  static Future<http.Response> addMedicationReminder(
      MedicationReminder medicationReminder) {
    return http.post(
        Uri.parse(
            ApiConstants.baseUrl + ApiConstants.medicationRemindersEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${dotenv.env['API_KEY']}'
        },
        body: jsonEncode({"data": medicationReminder}));
  }

  static Future<http.Response> deleteMedicationReminder(
      int medicationReminderId) {
    return http.delete(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.medicationRemindersEndpoint}/$medicationReminderId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${dotenv.env['API_KEY']}'
        });
  }

  // helper method:
  static List<MedicationReminder> parseMedicationReminders(
      String responseBody) {
    // flatten data:
    var flattenedResponse = flattenApiResponse(responseBody);

    // map data to list of announcements:
    var lst =
        flattenedResponse.map((e) => MedicationReminder.fromJson(e)).toList();
    return lst;
  }
}
