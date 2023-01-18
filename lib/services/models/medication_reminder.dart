import 'package:said/services/models/medication.dart';
import 'package:said/services/models/user.dart';

class MedicationReminder {
  final int id;
  final Medication medication;

  MedicationReminder(
      {required this.id,
      required this.medication,
      required this.user,
      required this.alreadyTaken,
      required this.dateTime});

  final User user;
  final bool alreadyTaken;
  final DateTime dateTime;

  factory MedicationReminder.fromJson(Map<String, dynamic> json) {
    return MedicationReminder(
      id: json['id'],
      medication: json['medication'],
      user: json['user'],
      alreadyTaken: json['alreadyTaken'],
      dateTime: json['dateTime'],
    );
  }
}
