class ReferralTreeStatistics {
  final int totalMembers;
  final int totalDepth;
  final int totalPurchase;
  final int totalCommission;

  ReferralTreeStatistics({
    required this.totalMembers,
    required this.totalDepth,
    required this.totalPurchase,
    required this.totalCommission,
  });

  factory ReferralTreeStatistics.fromJson(Map<String, dynamic> json) {
    return ReferralTreeStatistics(
      totalMembers: json['totalMembers'],
      totalDepth: json['totalDepth'],
      totalPurchase: json['totalPurchase'],
      totalCommission: json['totalCommission'],
    );
  }
}

class AdminReferralNode {
  final String userId;
  final String name;
  final String email;
  final String level;
  final int? totalReferrals; // Only on root
  final String? joinedAt; // Not on root
  final int? totalPurchase; // Not on root
  final int? totalCommissionGenerated; // Not on root
  final List<AdminReferralNode> children;
  final ReferralTreeStatistics? statistics; // Only on root

  AdminReferralNode({
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

  factory AdminReferralNode.fromJson(Map<String, dynamic> json) {
    var childrenList = json['children'] as List? ?? [];
    List<AdminReferralNode> children = childrenList
        .map((i) => AdminReferralNode.fromJson(i))
        .toList();

    return AdminReferralNode(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      level: json['level'],
      totalReferrals: json['totalReferrals'],
      joinedAt: json['joinedAt'],
      totalPurchase: json['totalPurchase'],
      totalCommissionGenerated: json['totalCommissionGenerated'],
      children: children,
      statistics: json['statistics'] != null
          ? ReferralTreeStatistics.fromJson(json['statistics'])
          : null,
    );
  }
}
