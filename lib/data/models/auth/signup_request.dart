class SignupRequest {
  final String userId;
  final String email;
  final String password;
  final String memberName;
  final String phone;
  final String? referredBy;

  SignupRequest({
    required this.userId,
    required this.email,
    required this.password,
    required this.memberName,
    required this.phone,
    this.referredBy,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'user_id': userId,
      'email': email,
      'password': password,
      'member_name': memberName,
      'phone': phone,
    };
    if (referredBy != null) {
      data['referred_by'] = referredBy;
    }
    return data;
  }
}
