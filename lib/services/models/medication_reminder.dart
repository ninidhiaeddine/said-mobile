import 'package:said/services/models/medication.dart';
import 'package:said/services/models/user.dart';

class MedicationReminder {
  final int? id;
  final Medication medication;

  MedicationReminder(
      {this.id,
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
      medication: Medication.fromJson(json['medication']),
      user: json['user'],
      alreadyTaken: json['alreadyTaken'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }

  Map toJson() => id != null
      ? {
          'id': id,
          'medication': medication,
          'user': user,
          'alreadyTaken': alreadyTaken,
          'dateTime': dateTime.toIso8601String(),
        }
      : {
          'medication': medication,
          'user': user,
          'alreadyTaken': alreadyTaken,
          'dateTime': dateTime.toIso8601String(),
        };
}
