class User {
  final String userId;
  final String email;
  final String name;
  final String role;

  User({
    required this.userId,
    required this.email,
    required this.name,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'email': email, 'name': name, 'role': role};
  }
}
