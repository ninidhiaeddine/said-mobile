import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:said/config/api_constants.dart';
import 'package:said/services/models/medication.dart';

class MedicationService {
  static Future<List<Medication>> getAllMedications(int userId) async {
    final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/$userId?populate[medications][populate][0]=user'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['API_KEY']}'
        });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return parseMedications(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Medications');
    }
  }

  static Future<http.Response> addMedication(Medication medication) {
    return http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.medicationsEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${dotenv.env['API_KEY']}'
        },
        body: jsonEncode({"data": medication}));
  }

  static Future<http.Response> updateMedication(Medication medication) {
    return http.put(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.medicationsEndpoint}/${medication.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${dotenv.env['API_KEY']}'
        },
        body: jsonEncode({"data": medication}));
  }

  static Future<http.Response> deleteMedication(int medicationId) {
    return http.delete(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.medicationsEndpoint}/$medicationId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${dotenv.env['API_KEY']}'
        });
  }

  // helper method:
  static List<Medication> parseMedications(String responseBody) {
    // extract medications out of the Json:
    var json = jsonDecode(responseBody);
    var meds = json['medications'];

    // map data to list of medications:
    var lst = List.generate(meds.length, (i) => Medication.fromJson(meds[i]));
    return lst;
  }
}
