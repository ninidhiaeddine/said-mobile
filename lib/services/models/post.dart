import 'package:said/services/models/post_like.dart';
import 'package:said/services/models/user.dart';

class Post {
  final int id;

  Post(
      {required this.id,
        required this.user,
        required this.datePosted,
        required this.postContent,
        this.postLikes});

  final User user;
  final String postContent;
  final DateTime datePosted;
  final List<PostLike>? postLikes;

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      user: json['user'],
      datePosted: json['datePosted'],
      postContent: json['postContent'],
      postLikes: json['postLikes'],
    );
  }
}
