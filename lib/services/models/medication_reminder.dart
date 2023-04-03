import 'package:said/services/models/medication.dart';

class MedicationReminder {
  final int? id;
  final Medication medication;

  MedicationReminder(
      {this.id,
      required this.medication,
      required this.alreadyTaken,
      required this.dateTime});

  final bool alreadyTaken;
  final DateTime dateTime;

  factory MedicationReminder.fromJson(Map<String, dynamic> json) {
    return MedicationReminder(
      id: json['id'],
      medication: Medication.fromJson(json['medication']),
      alreadyTaken: json['alreadyTaken'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }

  Map toJson() => id != null
      ? {
          'id': id,
          'medication': medication,
          'alreadyTaken': alreadyTaken,
          'dateTime': dateTime.toIso8601String(),
        }
      : {
          'medication': medication,
          'alreadyTaken': alreadyTaken,
          'dateTime': dateTime.toIso8601String(),
        };
}
