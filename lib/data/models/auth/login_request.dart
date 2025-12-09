class LoginRequest {
  final String userId;
  final String password;

  LoginRequest({required this.userId, required this.password});

  Map<String, dynamic> toJson() {
    return {'user_id': userId, 'password': password};
  }
}
