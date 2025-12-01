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
      userId: json['userId'],
      name: json['name'],
      level: json['level'],
      joinedAt: json['joinedAt'],
      totalPurchase: json['totalPurchase'],
      subReferrals: json['subReferrals'],
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
    var referralList = json['referrals'] as List;
    List<Referral> referrals = referralList
        .map((i) => Referral.fromJson(i))
        .toList();

    return ReferralSummary(
      totalReferrals: json['totalReferrals'],
      directReferrals: json['directReferrals'],
      indirectReferrals: json['indirectReferrals'],
      totalCommission: json['totalCommission'],
      referrals: referrals,
    );
  }
}
