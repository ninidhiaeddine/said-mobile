import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:said/config/api_constants.dart';
import 'package:said/services/dtos/register.dart';

Future<http.Response> register(Register registerDto) {
  return http.post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.registerEndpoint),
      body: jsonEncode(registerDto));
}
