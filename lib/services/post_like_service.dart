import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:said/config/api_constants.dart';
import 'package:said/services/models/post_like.dart';

class PostLikeService {
  static Future<List<PostLike>> getAllPostLikes(int postId) async {
    final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.postLikesEndpoint}?post=$postId'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['API_KEY']}'
        });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return parsePostLikes(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Post Likes');
    }
  }

  static Future<http.Response> addPostLike(PostLike postLike) {
    return http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postLikesEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${dotenv.env['API_KEY']}'
        },
        body: jsonEncode(PostLike));
  }

  static Future<http.Response> deletePostLike(PostLike postLike) {
    return http.delete(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postLikesEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${dotenv.env['API_KEY']}'
        },
        body: jsonEncode(PostLike));
  }

  // helper method:
  static List<PostLike> parsePostLikes(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return parsed.map((json) => PostLike.fromJson(json)).toList();
  }
}
