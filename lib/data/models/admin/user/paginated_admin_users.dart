import 'package:we/data/models/common/paginated_response.dart';

class AdminUserSummary {
  final String userId;
  final String email;
  final String name;
  final String? phone;
  final String level;
  final int points;
  final int totalPurchase;
  final int totalReferrals;
  final String? referrerId;
  final String? referrerName;
  final String status;
  final String createdAt;
  final String? lastLoginAt;

  AdminUserSummary({
    required this.userId,
    required this.email,
    required this.name,
    this.phone,
    required this.level,
    required this.points,
    required this.totalPurchase,
    required this.totalReferrals,
    this.referrerId,
    this.referrerName,
    required this.status,
    required this.createdAt,
    this.lastLoginAt,
  });

  factory AdminUserSummary.fromJson(Map<String, dynamic> json) {
    return AdminUserSummary(
      userId: (json['userId'] ?? json['user_id'])?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      phone: json['phone']?.toString(),
      level: json['level']?.toString() ?? 'BRONZE',
      points: (json['points'] as int?) ?? 0,
      totalPurchase:
          (json['totalPurchase'] ?? json['total_purchase']) as int? ?? 0,
      totalReferrals:
          (json['totalReferrals'] ?? json['total_referrals']) as int? ?? 0,
      referrerId: (json['referrerId'] ?? json['referrer_id'])?.toString(),
      referrerName: (json['referrerName'] ?? json['referrer_name'])?.toString(),
      status: json['status']?.toString() ?? 'ACTIVE',
      createdAt: (json['createdAt'] ?? json['created_at'])?.toString() ?? '',
      lastLoginAt: (json['lastLoginAt'] ?? json['last_login_at'])?.toString(),
    );
  }
}

typedef PaginatedAdminUsers = PaginatedResponse<AdminUserSummary>;

extension PaginatedAdminUsersExtension on PaginatedAdminUsers {
  static PaginatedAdminUsers fromJson(Map<String, dynamic> json) {
    return PaginatedResponse.fromJson(json, 'users', AdminUserSummary.fromJson);
  }

  List<AdminUserSummary> get users => items;
}
