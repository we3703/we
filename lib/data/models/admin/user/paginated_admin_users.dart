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
      userId: json['userId'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      level: json['level'],
      points: json['points'],
      totalPurchase: json['totalPurchase'],
      totalReferrals: json['totalReferrals'],
      referrerId: json['referrerId'],
      referrerName: json['referrerName'],
      status: json['status'],
      createdAt: json['createdAt'],
      lastLoginAt: json['lastLoginAt'],
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
