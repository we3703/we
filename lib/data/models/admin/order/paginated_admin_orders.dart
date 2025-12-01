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
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      level: json['level'],
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
      orderId: json['orderId'],
      user: UserInAdminOrder.fromJson(json['user']),
      product: ProductInfo.fromJson(json['product']),
      quantity: json['quantity'],
      totalPrice: json['totalPrice'],
      status: json['status'],
      trackingNumber: json['trackingNumber'],
      orderedAt: json['orderedAt'],
      shippedAt: json['shippedAt'],
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
