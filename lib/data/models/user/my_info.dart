class MyInfo {
  final String userId;
  final String name;
  final String? phone;
  final int points;
  final String level;
  final String? referrerId;
  final String? referrerName;
  final int totalReferrals;
  final String createdAt;

  MyInfo({
    required this.userId,
    required this.name,
    this.phone,
    required this.points,
    required this.level,
    this.referrerId,
    this.referrerName,
    required this.totalReferrals,
    required this.createdAt,
  });

  factory MyInfo.fromJson(Map<String, dynamic> json) {
    return MyInfo(
      userId: json['user_id'] ?? json['userId'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone']?.toString(),
      points: json['points'] ?? json['point'] ?? 0,
      level: json['level'] ?? json['grade'] ?? '',
      referrerId: json['referrer_id'] ?? json['referrerId'],
      referrerName: json['referrer_name'] ?? json['referrerName'],
      totalReferrals: json['total_referrals'] ?? json['totalReferrals'] ?? 0,
      createdAt: json['created_at'] ?? json['createdAt'] ?? '',
    );
  }
}
