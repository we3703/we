class ReferralNodeEntity {
  final String userId;
  final String name;
  final String level;
  final String? joinedAt;
  final List<ReferralNodeEntity> children;

  ReferralNodeEntity({
    required this.userId,
    required this.name,
    required this.level,
    this.joinedAt,
    required this.children,
  });
}
