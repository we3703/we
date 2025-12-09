class MyInfoEntity {
  final String userId;
  final String name;
  final String? phone;
  final int points;
  final String level;
  final String? referrerId;
  final String? referrerName;
  final int totalReferrals;
  final String createdAt;

  MyInfoEntity({
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
}
