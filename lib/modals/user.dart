class User {
  final String id;
  final String username;
  final String email;

  User({
    this.id,
    this.username,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
      id: jsonData['id'],
      username: jsonData['username'],
      email: jsonData['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
    };
  }
}
