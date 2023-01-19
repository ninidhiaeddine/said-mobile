class Auth {
  final String identifier;
  final String password;

  const Auth({required this.identifier, required this.password});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      identifier: json['identifier'],
      password: json['password'],
    );
  }

  Map toJson() => {
    'identifier': identifier,
    'password': password,
  };
}
