class ChangePasswordRequest {
  final String email;
  final String code;
  final String newPassword;

  ChangePasswordRequest({
    required this.email,
    required this.code,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {'email': email, 'code': code, 'new_password': newPassword};
  }
}
