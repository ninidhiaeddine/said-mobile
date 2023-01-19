import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:said/config/api_constants.dart';
import 'package:said/services/dtos/register.dart';

class RegisterService {
  static Future<http.Response> register(Register registerDto) {
    return http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.registerEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(registerDto));
  }
}

