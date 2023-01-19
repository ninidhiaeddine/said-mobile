class User {
  final int id;
  final String username;
  final String email;
  final String? phoneNumber;
  final int? age;
  final int? sex;

  User(
      {required this.id,
      required this.username,
      required this.email,
      this.phoneNumber,
      this.age,
      this.sex});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      age: json['age'],
      sex: json['sex'],
    );
  }

  Map toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'phoneNumber': phoneNumber,
    'age': age,
    'sex': sex,
  };
}
