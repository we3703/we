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
        .map((i) => ReferralNode.fromJson(i))
        .toList();

    return ReferralNode(
      userId: json['user_id'] ?? json['userId'] ?? '',
      name: json['name'] ?? '',
      level: json['level'] ?? '',
      joinedAt: json['joined_at'] ?? json['joinedAt'],
      totalPurchase: json['total_purchase'] ?? json['totalPurchase'],
      totalCommissionGenerated:
          json['total_commission_generated'] ??
          json['totalCommissionGenerated'],
      children: children,
    );
  }
}
