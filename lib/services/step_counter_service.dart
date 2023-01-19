import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:said/config/api_constants.dart';
import 'package:said/services/models/step_counter.dart';

class StepCounterService {
  static Future<List<StepCounter>> getAllStepCounters(int userId) async {
    final response = await http.get(Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.stepCountersEndpoint}?user=$userId'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return parseStepCounters(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Announcements');
    }
  }

  static Future<StepCounter> getStepCounter(
      int userId, DateTime targetDate) async {
    final response = await http.get(Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.stepCountersEndpoint}?user=$userId&date=$targetDate'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return StepCounter.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Ste');
    }
  }

  static Future<http.Response> addStepCounter(StepCounter stepCounter) {
    return http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.stepCountersEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(stepCounter));
  }

  static Future<http.Response> updateStepCounter(StepCounter stepCounter) {
    return http.put(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.stepCountersEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(stepCounter));
  }

  // helper method:
  static List<StepCounter> parseStepCounters(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return parsed.map((json) => StepCounter.fromJson(json)).toList();
  }
}
