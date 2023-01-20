import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:said/config/api_constants.dart';
import 'package:said/services/models/post.dart';
import 'package:said/utils/flatten_api_response.dart';

class PostService {
  static Future<List<Post>> getAllPosts() async {
    final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.postsEndpoint}'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['API_KEY']}'
        });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return parsePosts(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Posts');
    }
  }

  static Future<http.Response> addPost(Post post) {
    return http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postsEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${dotenv.env['API_KEY']}'
        },
        body: jsonEncode(post));
  }

  static Future<http.Response> updatePost(Post post) {
    return http.put(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postsEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${dotenv.env['API_KEY']}'
        },
        body: jsonEncode(post));
  }

  static Future<http.Response> deletePost(Post post) {
    return http.delete(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postsEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${dotenv.env['API_KEY']}'
        },
        body: jsonEncode(post));
  }

  // helper method:
  static List<Post> parsePosts(String responseBody) {
    // flatten data:
    var flattenedResponse = flattenApiResponse(responseBody);

    // map data to list of announcements:
    var lst = flattenedResponse.map((e) => Post.fromJson(e)).toList();
    return lst;
  }
}
