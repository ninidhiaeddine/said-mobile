class Announcement {
  final int announcementId;
  final String content;
  final DateTime dateSent;

  Announcement(
      {required this.announcementId,
        required this.content,
        required this.dateSent});

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      announcementId: json['announcementId'],
      content: json['content'],
      dateSent: json['dateSent'],
    );
  }
}
