import 'package:said/types/sex.dart';

class User {
  final int? id;
  final String username;
  final String email;

  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final int? age;
  final Sex? sex;

  User(
      {this.id,
      required this.username,
      required this.email,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.age,
      this.sex});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      age: json['age'],
      sex: sexToEnum(json['sex']),
    );
  }

  Map toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'phoneNumber': phoneNumber,
    'age': age,
    'sex': sexToString(sex!),
  };
}
