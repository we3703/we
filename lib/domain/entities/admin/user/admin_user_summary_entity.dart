class AdminUserSummaryEntity {
  final String userId;
  final String email;
  final String name;
  final String? phone;
  final String level;
  final int points;
  final int totalPurchase;
  final int totalReferrals;
  final String? referrerId;
  final String? referrerName;
  final String status;
  final String createdAt;
  final String? lastLoginAt;

  AdminUserSummaryEntity({
    required this.userId,
    required this.email,
    required this.name,
    this.phone,
    required this.level,
    required this.points,
    required this.totalPurchase,
    required this.totalReferrals,
    this.referrerId,
    this.referrerName,
    required this.status,
    required this.createdAt,
    this.lastLoginAt,
  });
}
