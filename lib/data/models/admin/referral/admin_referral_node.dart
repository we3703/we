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
      totalMembers:
          (json['totalMembers'] ?? json['total_members']) as int? ?? 0,
      totalDepth: (json['totalDepth'] ?? json['total_depth']) as int? ?? 0,
      totalPurchase:
          (json['totalPurchase'] ?? json['total_purchase']) as int? ?? 0,
      totalCommission:
          (json['totalCommission'] ?? json['total_commission']) as int? ?? 0,
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
        .map((i) => AdminReferralNode.fromJson(i as Map<String, dynamic>))
        .toList();

    return AdminReferralNode(
      userId: (json['userId'] ?? json['user_id'])?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      level: json['level']?.toString() ?? 'BRONZE',
      totalReferrals:
          (json['totalReferrals'] ?? json['total_referrals']) as int?,
      joinedAt: (json['joinedAt'] ?? json['joined_at'])?.toString(),
      totalPurchase: (json['totalPurchase'] ?? json['total_purchase']) as int?,
      totalCommissionGenerated:
          (json['totalCommissionGenerated'] ??
                  json['total_commission_generated'])
              as int?,
      children: children,
      statistics: json['statistics'] != null
          ? ReferralTreeStatistics.fromJson(
              json['statistics'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}
