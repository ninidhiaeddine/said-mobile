class Register {
  final String username;
  final String email;
  final String password;

  const Register(
      {required this.username, required this.email, required this.password});

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map toJson() => {
    'username': username,
    'email': email,
    'password': password
  };
}
