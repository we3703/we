class ReferralEntity {
  final String userId;
  final String name;
  final String level;
  final String joinedAt;
  final int totalPurchase;
  final int subReferrals;

  ReferralEntity({
    required this.userId,
    required this.name,
    required this.level,
    required this.joinedAt,
    required this.totalPurchase,
    required this.subReferrals,
  });
}
