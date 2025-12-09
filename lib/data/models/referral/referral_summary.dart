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
      userId: json['user_id'] ?? json['userId'] ?? '',
      name: json['name'] ?? '',
      level: json['level'] ?? '',
      joinedAt: json['joined_at'] ?? json['joinedAt'] ?? '',
      totalPurchase: json['total_purchase'] ?? json['totalPurchase'] ?? 0,
      subReferrals: json['sub_referrals'] ?? json['subReferrals'] ?? 0,
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
        .map((i) => Referral.fromJson(i))
        .toList();

    return ReferralSummary(
      totalReferrals: json['total_referrals'] ?? json['totalReferrals'] ?? 0,
      directReferrals: json['direct_referrals'] ?? json['directReferrals'] ?? 0,
      indirectReferrals:
          json['indirect_referrals'] ?? json['indirectReferrals'] ?? 0,
      totalCommission: json['total_commission'] ?? json['totalCommission'] ?? 0,
      referrals: referrals,
    );
  }
}
