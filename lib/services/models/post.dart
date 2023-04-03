import 'package:said/services/models/post_like.dart';
import 'package:said/services/models/user.dart';

class Post {
  final int? id;

  Post(
      {this.id,
      required this.user,
      required this.postContent,
      this.createdAt,
      this.postLikes});

  final User user;
  final String postContent;
  final DateTime? createdAt;
  final List<PostLike>? postLikes;

  factory Post.fromJson(Map<String, dynamic> json) {
    var postLikes = json['postLikes'];

    return Post(
      id: json['id'],
      user: User.fromJson(json['user']),
      createdAt: DateTime.parse(json['createdAt']),
      postContent: json['postContent'],
      postLikes: List.generate(
          postLikes.length, (i) => PostLike.fromJson(postLikes[i])),
    );
  }

  Map toJson() => id != null
      ? {
          'id': id,
          'user': user,
          'createdAt': createdAt!.toIso8601String(),
          'postContent': postContent,
          'postLikes': postLikes,
        }
      : {
          'user': user,
          'createdAt': createdAt!.toIso8601String(),
          'postContent': postContent,
          'postLikes': postLikes,
        };
}
