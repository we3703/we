class User {
  final String userId;
  final String name;
  final String? phone;
  final int? points;
  final String? level;
  final String? referrerId;
  final String? referrerName;
  final int? totalReferrals;
  final String? createdAt;
  final String? role;

  User({
    required this.userId,
    required this.name,
    this.phone,
    this.points,
    this.level,
    this.referrerId,
    this.referrerName,
    this.totalReferrals,
    this.createdAt,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: (json['user_id'] ?? json['userId'] ?? '').toString(),
      name: (json['member_name'] ?? json['name'] ?? '').toString(),
      phone: json['phone']?.toString(),
      points: json['point'] as int?,
      level: json['grade']?.toString() ?? json['level']?.toString(),
      referrerId: json['referrer_id']?.toString(),
      referrerName: json['referrer_name']?.toString(),
      totalReferrals: json['total_referrals'] as int?,
      createdAt: json['created_at']?.toString(),
      role: json['role']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'phone': phone,
      'points': points,
      'level': level,
      'referrer_id': referrerId,
      'referrer_name': referrerName,
      'total_referrals': totalReferrals,
      'created_at': createdAt,
      'role': role,
    };
  }
}
