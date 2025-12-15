class Referral {
  final String userId;
  final String name;
  final String level;
  final String joinedAt;
  final int totalPurchase;
  final int subReferrals;

  Referral({
    required this.userId,
    required this.name,
    required this.level,
    required this.joinedAt,
    required this.totalPurchase,
    required this.subReferrals,
  });

  factory Referral.fromJson(Map<String, dynamic> json) {
    return Referral(
      userId: (json['user_id'] ?? json['userId'])?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      level: json['level']?.toString() ?? 'BRONZE',
      joinedAt: (json['joined_at'] ?? json['joinedAt'])?.toString() ?? '',
      totalPurchase:
          (json['total_purchase'] ?? json['totalPurchase']) as int? ?? 0,
      subReferrals:
          (json['sub_referrals'] ?? json['subReferrals']) as int? ?? 0,
    );
  }
}

class ReferralSummary {
  final int totalReferrals;
  final int directReferrals;
  final int indirectReferrals;
  final int totalCommission;
  final List<Referral> referrals;

  ReferralSummary({
    required this.totalReferrals,
    required this.directReferrals,
    required this.indirectReferrals,
    required this.totalCommission,
    required this.referrals,
  });

  factory ReferralSummary.fromJson(Map<String, dynamic> json) {
    var referralList = json['referrals'] as List? ?? [];
    List<Referral> referrals = referralList
        .map((i) => Referral.fromJson(i as Map<String, dynamic>))
        .toList();

    return ReferralSummary(
      totalReferrals:
          (json['total_referrals'] ?? json['totalReferrals']) as int? ?? 0,
      directReferrals:
          (json['direct_referrals'] ?? json['directReferrals']) as int? ?? 0,
      indirectReferrals:
          (json['indirect_referrals'] ?? json['indirectReferrals']) as int? ??
          0,
      totalCommission:
          (json['total_commission'] ?? json['totalCommission']) as int? ?? 0,
      referrals: referrals,
    );
  }
}
