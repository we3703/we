import 'package:we/data/models/common/product_info.dart';
import 'package:we/data/models/order/shipping_address.dart';

class StatusHistoryItem {
  final String status;
  final String description;
  final String timestamp;

  StatusHistoryItem({
    required this.status,
    required this.description,
    required this.timestamp,
  });

  factory StatusHistoryItem.fromJson(Map<String, dynamic> json) {
    return StatusHistoryItem(
      status: json['status']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      timestamp: json['timestamp']?.toString() ?? '',
    );
  }
}

class OrderDetail {
  final String orderId;
  final ProductInfo product;
  final int quantity;
  final int totalPrice;
  final int pointsUsed;
  final String status;
  final ShippingAddress shippingAddress;
  final String? trackingNumber;
  final String? courier;
  final List<StatusHistoryItem> statusHistory;
  final String orderedAt;

  OrderDetail({
    required this.orderId,
    required this.product,
    required this.quantity,
    required this.totalPrice,
    required this.pointsUsed,
    required this.status,
    required this.shippingAddress,
    this.trackingNumber,
    this.courier,
    required this.statusHistory,
    required this.orderedAt,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    var historyList = (json['statusHistory'] ?? json['status_history']) as List? ?? [];
    List<StatusHistoryItem> history = historyList
        .map((i) => StatusHistoryItem.fromJson(i as Map<String, dynamic>))
        .toList();

    return OrderDetail(
      orderId: (json['orderId'] ?? json['order_id'])?.toString() ?? '',
      product: ProductInfo.fromJson(json['product'] ?? {}),
      quantity: json['quantity'] as int? ?? 0,
      totalPrice: (json['totalPrice'] ?? json['total_price']) as int? ?? 0,
      pointsUsed: (json['pointsUsed'] ?? json['points_used']) as int? ?? 0,
      status: json['status']?.toString() ?? 'PENDING',
      shippingAddress: ShippingAddress.fromJson((json['shippingAddress'] ?? json['shipping_address']) ?? {}),
      trackingNumber: (json['trackingNumber'] ?? json['tracking_number'])?.toString(),
      courier: json['courier']?.toString(),
      statusHistory: history,
      orderedAt: (json['orderedAt'] ?? json['ordered_at'])?.toString() ?? '',
    );
  }
}
