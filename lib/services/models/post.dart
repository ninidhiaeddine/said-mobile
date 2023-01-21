import 'package:said/services/models/post_like.dart';
import 'package:said/services/models/user.dart';

class Post {
  final int? id;

  Post(
      {this.id,
        required this.user,
        required this.createdAt,
        required this.postContent,
        this.postLikes});

  final User user;
  final String postContent;
  final DateTime createdAt;
  final List<PostLike>? postLikes;

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      user: json['user'],
      createdAt: DateTime.parse(json['createdAt']),
      postContent: json['postContent'],
      postLikes: json['postLikes'],
    );
  }

  Map toJson() => {
    'id': id,
    'user': user,
    'createdAt': createdAt,
    'postContent': postContent,
    'postLikes': postLikes,
  };
}
