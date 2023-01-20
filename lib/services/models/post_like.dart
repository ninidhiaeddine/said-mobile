import 'package:said/services/models/post.dart';
import 'package:said/services/models/user.dart';

class PostLike {
  final int? id;

  PostLike(
      {this.id,
        required this.user,
        required this.post});

  final Post post;
  final User user;

  factory PostLike.fromJson(Map<String, dynamic> json) {
    return PostLike(
      id: json['id'],
      user: json['user'],
      post: json['post'],
    );
  }

  Map toJson() => {
    'id': id,
    'user': user,
    'post': post,
  };
}
