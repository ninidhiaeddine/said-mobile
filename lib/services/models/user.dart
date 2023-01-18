class User {
  final int id;
  final String username;
  final String email;
  final String password;
  final String? phoneNumber;
  final int? age;
  final int? sex;

  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.password,
      this.phoneNumber,
      this.age,
      this.sex});

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

  Map toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'password': password,
    'phoneNumber': phoneNumber,
    'age': age,
    'sex': sex,
  };
}
