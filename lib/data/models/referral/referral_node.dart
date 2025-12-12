class ReferralNode {
  final String userId;
  final String name;
  final String level;
  final String? joinedAt;
  final int? totalPurchase;
  final int? totalCommissionGenerated;
  final List<ReferralNode> children;

  ReferralNode({
    required this.userId,
    required this.name,
    required this.level,
    this.joinedAt,
    this.totalPurchase,
    this.totalCommissionGenerated,
    required this.children,
  });

  factory ReferralNode.fromJson(Map<String, dynamic> json) {
    var childrenList = json['children'] as List? ?? [];
    List<ReferralNode> children = childrenList
        .map((i) => ReferralNode.fromJson(i as Map<String, dynamic>))
        .toList();

    return ReferralNode(
      userId: (json['user_id'] ?? json['userId'])?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      level: json['level']?.toString() ?? 'BRONZE',
      joinedAt: (json['joined_at'] ?? json['joinedAt'])?.toString(),
      totalPurchase: (json['total_purchase'] ?? json['totalPurchase']) as int?,
      totalCommissionGenerated: (json['total_commission_generated'] ?? json['totalCommissionGenerated']) as int?,
      children: children,
    );
  }
}
