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
      status: json['status'],
      description: json['description'],
      timestamp: json['timestamp'],
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
    var historyList = json['statusHistory'] as List;
    List<StatusHistoryItem> history = historyList
        .map((i) => StatusHistoryItem.fromJson(i))
        .toList();

    return OrderDetail(
      orderId: json['orderId'],
      product: ProductInfo.fromJson(json['product']),
      quantity: json['quantity'],
      totalPrice: json['totalPrice'],
      pointsUsed: json['pointsUsed'],
      status: json['status'],
      shippingAddress: ShippingAddress.fromJson(json['shippingAddress']),
      trackingNumber: json['trackingNumber'],
      courier: json['courier'],
      statusHistory: history,
      orderedAt: json['orderedAt'],
    );
  }
}
