import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:said/config/api_constants.dart';
import 'package:said/services/dtos/auth.dart';

class AuthService {
  static Future<http.Response> authenticate(Auth authDto) {
    return http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.authEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(authDto));
  }
}

