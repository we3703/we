class MyInfo {
  final String userId;
  final String email;
  final String name;
  final String? phone;
  final String referralCode;
  final int points;
  final String level;
  final String? referrerId;
  final String? referrerName;
  final int totalReferrals;
  final String createdAt;

  MyInfo({
    required this.userId,
    required this.email,
    required this.name,
    this.phone,
    required this.referralCode,
    required this.points,
    required this.level,
    this.referrerId,
    this.referrerName,
    required this.totalReferrals,
    required this.createdAt,
  });

  factory MyInfo.fromJson(Map<String, dynamic> json) {
    return MyInfo(
      userId: json['userId'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      referralCode: json['referralCode'],
      points: json['points'],
      level: json['level'],
      referrerId: json['referrerId'],
      referrerName: json['referrerName'],
      totalReferrals: json['totalReferrals'],
      createdAt: json['createdAt'],
    );
  }
}
