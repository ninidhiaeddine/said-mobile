import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:said/config/api_constants.dart';
import 'package:said/services/models/post.dart';

class PostService {
  static Future<List<Post>> getAllPosts() async {
    final response = await http.get(Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.postsEndpoint}'));

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
        },
        body: jsonEncode(post));
  }

  static Future<http.Response> updatePost(Post post) {
    return http.put(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.postsEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(post));
  }

  static Future<http.Response> deletePost(Post post) {
    return http.delete(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.medicationsEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(post));
  }

  // helper method:
  static List<Post> parsePosts(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return parsed.map((json) => Post.fromJson(json)).toList();
  }
}
