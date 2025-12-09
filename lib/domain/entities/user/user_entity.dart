class UserEntity {
  final String userId;
  final String name;
  final String? phone;
  final int? points;
  final String? level;
  final String? referrerId;
  final String? referrerName;
  final int? totalReferrals;
  final String? createdAt;
  final String? role;

  UserEntity({
    required this.userId,
    required this.name,
    this.phone,
    this.points,
    this.level,
    this.referrerId,
    this.referrerName,
    this.totalReferrals,
    this.createdAt,
    this.role,
  });
}
