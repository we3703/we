class UserInAdminOrderEntity {
  final String userId;
  final String name;
  final String email;
  final String? phone;
  final String level;

  UserInAdminOrderEntity({
    required this.userId,
    required this.name,
    required this.email,
    this.phone,
    required this.level,
  });
}
