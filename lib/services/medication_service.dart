import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:said/config/api_constants.dart';
import 'package:said/services/models/medication.dart';
import 'package:said/utils/flatten_api_response.dart';

class MedicationService {
  static Future<List<Medication>> getAllMedications(int userId) async {
    final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.medicationsEndpoint}?user=$userId'),
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
      throw Exception('Failed to load Announcements');
    }
  }

  static Future<http.Response> addMedication(Medication medication) {
    return http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.medicationsEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${dotenv.env['API_KEY']}'
        },
        body: jsonEncode(medication));
  }

  static Future<http.Response> updateMedication(Medication medication) {
    return http.put(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.medicationsEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${dotenv.env['API_KEY']}'
        },
        body: jsonEncode(medication));
  }

  static Future<http.Response> deleteMedication(Medication medication) {
    return http.delete(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.medicationsEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${dotenv.env['API_KEY']}'
        },
        body: jsonEncode(medication));
  }

  // helper method:
  static List<Medication> parseMedications(String responseBody) {
    // flatten data:
    var flattenedResponse = flattenApiResponse(responseBody);

    // map data to list of announcements:
    var lst = flattenedResponse.map((e) => Medication.fromJson(e)).toList();
    return lst;
  }
}
