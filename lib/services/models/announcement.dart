class Announcement {
  final int id;
  final String content;
  final DateTime dateSent;

  const Announcement(
      {required this.id,
      required this.content,
      required this.dateSent});

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'],
      content: json['content'],
      dateSent: json['dateSent'],
    );
  }
}
