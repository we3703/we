class UpdateMyInfoResponse {
  final String userId;
  final String name;
  final String phone;
  final String updatedAt;

  UpdateMyInfoResponse({
    required this.userId,
    required this.name,
    required this.phone,
    required this.updatedAt,
  });

  factory UpdateMyInfoResponse.fromJson(Map<String, dynamic> json) {
    return UpdateMyInfoResponse(
      userId: json['userId'] ?? json['user_id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      updatedAt: json['updatedAt'] ?? json['updated_at'] ?? '',
    );
  }
}
