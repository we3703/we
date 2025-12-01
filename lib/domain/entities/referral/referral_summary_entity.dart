import 'referral_entity.dart';

class ReferralSummaryEntity {
  final int totalReferrals;
  final int directReferrals;
  final int indirectReferrals;
  final int totalCommission;
  final List<ReferralEntity> referrals;

  ReferralSummaryEntity({
    required this.totalReferrals,
    required this.directReferrals,
    required this.indirectReferrals,
    required this.totalCommission,
    required this.referrals,
  });
}
