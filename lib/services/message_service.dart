import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;
import 'package:said/config/api_constants.dart';
import 'package:said/services/models/message.dart';

class MessageService {
  static Future<http.Response> addMessage(Message message) {
    return http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.messagesEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${dotenv.env['API_KEY']}'
        },
        body: jsonEncode(message));
  }
}
