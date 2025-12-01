class MyInfoEntity {
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

  MyInfoEntity({
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
}
