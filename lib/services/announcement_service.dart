import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:said/config/api_constants.dart';
import 'package:said/services/models/announcement.dart';

class AnnouncementService {
  static Future<Announcement> getAnnouncement(int id) async {
    final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.announcementsEndpoint}/$id'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['API_KEY']}'
        });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Announcement.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Announcement');
    }
  }

  static Future<List<Announcement>> getAllAnnouncements() async {
    final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.announcementsEndpoint),
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['API_KEY']}'
        });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return parseAnnouncements(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Announcements');
    }
  }

  // helper method:
  static List<Announcement> parseAnnouncements(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return parsed.map((json) => Announcement.fromJson(json)).toList();
  }
}
