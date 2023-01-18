class Auth {
  final String email;
  final String password;

  const Auth({required this.email, required this.password});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      email: json['email'],
      password: json['password'],
    );
  }

  Map toJson() => {
    'email': email,
    'password': password,
  };
}
