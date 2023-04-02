import 'package:said/services/models/user.dart';

class Medication {
  Medication(
      {this.id,
      required this.user,
      required this.name,
      required this.amount,
      required this.type,
      required this.method,
      required this.startDate,
      required this.endDate});

  int? id;
  final User user;
  final String name;
  final double amount;
  final String type;
  final String method;
  final DateTime startDate;
  final DateTime endDate;

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
        id: json['id'],
        user: User.fromJson(json['user']),
        name: json['name'],
        amount: (json['amount'] as int).toDouble(),
        type: json['type'],
        method: json['method'],
        startDate: DateTime.parse(json['startDate']),
        endDate: DateTime.parse(json['endDate']));
  }

  Map toJson() => id != null
      ? {
          'id': id,
          'user': user,
          'name': name,
          'amount': amount,
          'type': type,
          'method': method,
          'startDate': startDate.toIso8601String(),
          'endDate': endDate.toIso8601String(),
        }
      : {
          'user': user,
          'name': name,
          'amount': amount,
          'type': type,
          'method': method,
          'startDate': startDate.toIso8601String(),
          'endDate': endDate.toIso8601String(),
        };
}
