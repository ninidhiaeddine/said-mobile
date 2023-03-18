import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:said/config/api_constants.dart';
import 'package:said/services/models/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserService {
  static Future<User> getUser(int id) async {
    final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/$id'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['API_KEY']}'
        });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return User.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load User | ${response.body}');
    }
  }

  static Future<http.Response> updateUser(int id, User user) {
    return http.put(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${dotenv.env['API_KEY']}'
        },
        body: jsonEncode(user));
  }
}
