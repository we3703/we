class ReferralNode {
  final String userId;
  final String name;
  final String level;
  final String? joinedAt;
  final List<ReferralNode> children;

  ReferralNode({
    required this.userId,
    required this.name,
    required this.level,
    this.joinedAt,
    required this.children,
  });

  factory ReferralNode.fromJson(Map<String, dynamic> json) {
    var childrenList = json['children'] as List? ?? [];
    List<ReferralNode> children = childrenList
        .map((i) => ReferralNode.fromJson(i))
        .toList();

    return ReferralNode(
      userId: json['userId'],
      name: json['name'],
      level: json['level'],
      joinedAt: json['joinedAt'],
      children: children,
    );
  }
}
