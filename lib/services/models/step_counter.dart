import 'package:said/services/models/user.dart';

class StepCounter {
  final int id;

  StepCounter(
      {required this.id,
        required this.user,
        required this.steps,
        required this.date});

  final User user;
  final int steps;
  final DateTime date;

  factory StepCounter.fromJson(Map<String, dynamic> json) {
    return StepCounter(
      id: json['id'],
      user: json['user'],
      steps: json['steps'],
      date: json['date'],
    );
  }

  Map toJson() => {
    'id': id,
    'user': user,
    'steps': steps,
    'date': date
  };
}