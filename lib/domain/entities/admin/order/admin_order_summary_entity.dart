import 'package:we/domain/entities/common/product_info_entity.dart';
import 'package:we/domain/entities/admin/order/user_in_admin_order_entity.dart';

class AdminOrderSummaryEntity {
  final String orderId;
  final UserInAdminOrderEntity user;
  final ProductInfoEntity product;
  final int quantity;
  final int totalPrice;
  final String status;
  final String? trackingNumber;
  final String orderedAt;
  final String? shippedAt;

  AdminOrderSummaryEntity({
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
}
