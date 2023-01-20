class Announcement {
  final int id;
  final String content;
  final DateTime createdAt;

  const Announcement(
      {required this.id,
      required this.content,
      required this.createdAt});

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt'])
    );
  }

  Map toJson() => {
    'id': id,
    'content': content,
    'dateSent': createdAt
  };
}
