class users{
  String username;
  String password;

  users({required this.username, required this.password});

  factory users.fromJson(Map<String, dynamic> json) {
    return users(
      username: json['username'] as String,
      password: json['password'] as String,
    );
  }
}