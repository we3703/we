class LicenseVerifyResponse {
  final String email;
  final bool verified;

  LicenseVerifyResponse({required this.email, required this.verified});

  factory LicenseVerifyResponse.fromJson(Map<String, dynamic> json) {
    return LicenseVerifyResponse(
      email: json['email'],
      verified: json['verified'],
    );
  }
}
