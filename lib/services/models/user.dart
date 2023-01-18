class User {
  final int id;
  final String username;
  final String email;
  final String password;

  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.password,
      this.phoneNumber,
      this.age,
      this.sex});

  final String? phoneNumber;
  final int? age;
  final int? sex;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        password: json['password'],
        phoneNumber: json['phoneNumber'],
        age: json['age'],
        sex: json['sex'],
    );
  }
}
