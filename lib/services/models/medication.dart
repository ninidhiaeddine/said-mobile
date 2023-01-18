import 'package:said/services/models/user.dart';

class Medication {
  const Medication(
      {required this.id,
      required this.user,
      required this.name,
      required this.amount,
      required this.type,
      required this.method,
      required this.startDate,
      required this.endDate});

  final int id;
  final User user;
  final String name;
  final double amount;
  final int type;
  final int method;
  final DateTime startDate;
  final DateTime endDate;

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
        id: json['id'],
        user: json['user'],
        name: json['name'],
        amount: json['amount'],
        type: json['type'],
        method: json['method'],
        startDate: json['startDate'],
        endDate: json['endDate']);
  }

  Map toJson() => {
    'id': id,
    'user': user,
    'name': name,
    'amount': amount,
    'type': type,
    'method': method,
    'startDate': startDate,
    'endDate': endDate,
  };
}
