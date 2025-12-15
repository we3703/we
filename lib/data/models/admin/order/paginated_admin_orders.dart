import 'package:we/data/models/common/paginated_response.dart';
import 'package:we/data/models/common/product_info.dart';

class UserInAdminOrder {
  final String userId;
  final String name;
  final String email;
  final String level;

  UserInAdminOrder({
    required this.userId,
    required this.name,
    required this.email,
    required this.level,
  });

  factory UserInAdminOrder.fromJson(Map<String, dynamic> json) {
    return UserInAdminOrder(
      userId: (json['userId'] ?? json['user_id'])?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      level: json['level']?.toString() ?? 'BRONZE',
    );
  }
}

class AdminOrderSummary {
  final String orderId;
  final UserInAdminOrder user;
  final ProductInfo product;
  final int quantity;
  final int totalPrice;
  final String status;
  final String? trackingNumber;
  final String orderedAt;
  final String? shippedAt;

  AdminOrderSummary({
    required this.orderId,
    required this.user,
    required this.product,
    required this.quantity,
    required this.totalPrice,
    required this.status,
    this.trackingNumber,
    required this.orderedAt,
    this.shippedAt,
  });

  factory AdminOrderSummary.fromJson(Map<String, dynamic> json) {
    return AdminOrderSummary(
      orderId: (json['orderId'] ?? json['order_id'])?.toString() ?? '',
      user: UserInAdminOrder.fromJson(json['user'] ?? {}),
      product: ProductInfo.fromJson(json['product'] ?? {}),
      quantity: (json['quantity'] as int?) ?? 0,
      totalPrice: (json['totalPrice'] ?? json['total_price']) as int? ?? 0,
      status: json['status']?.toString() ?? 'PENDING',
      trackingNumber: (json['trackingNumber'] ?? json['tracking_number'])
          ?.toString(),
      orderedAt: (json['orderedAt'] ?? json['ordered_at'])?.toString() ?? '',
      shippedAt: (json['shippedAt'] ?? json['shipped_at'])?.toString(),
    );
  }
}

typedef PaginatedAdminOrders = PaginatedResponse<AdminOrderSummary>;

extension PaginatedAdminOrdersExtension on PaginatedAdminOrders {
  static PaginatedAdminOrders fromJson(Map<String, dynamic> json) {
    return PaginatedResponse.fromJson(
      json,
      'orders',
      AdminOrderSummary.fromJson,
    );
  }

  List<AdminOrderSummary> get orders => items;
}
