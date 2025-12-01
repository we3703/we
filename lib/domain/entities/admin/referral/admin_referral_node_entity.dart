import 'referral_tree_statistics_entity.dart';

class AdminReferralNodeEntity {
  final String userId;
  final String name;
  final String email;
  final String level;
  final int? totalReferrals;
  final String? joinedAt;
  final int? totalPurchase;
  final int? totalCommissionGenerated;
  final List<AdminReferralNodeEntity> children;
  final ReferralTreeStatisticsEntity? statistics;

  AdminReferralNodeEntity({
    required this.userId,
    required this.name,
    required this.email,
    required this.level,
    this.totalReferrals,
    this.joinedAt,
    this.totalPurchase,
    this.totalCommissionGenerated,
    required this.children,
    this.statistics,
  });
}
