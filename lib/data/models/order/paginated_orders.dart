import 'package:we/data/models/common/paginated_response.dart';

class OrderSummary {
  final String orderId;
  final String productId;
  final String productName;
  final String productImage;
  final int quantity;
  final int totalPrice;
  final String status;
  final String? trackingNumber;
  final String orderedAt;
  final String? shippedAt;

  OrderSummary({
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.quantity,
    required this.totalPrice,
    required this.status,
    this.trackingNumber,
    required this.orderedAt,
    this.shippedAt,
  });

  factory OrderSummary.fromJson(Map<String, dynamic> json) {
    return OrderSummary(
      orderId: (json['order_id'] ?? json['orderId'] ?? '').toString(),
      productId: (json['product_id'] ?? json['productId'] ?? '').toString(),
      productName: json['product_name'] ?? json['productName'] ?? '',
      productImage: json['product_image'] ?? json['productImage'] ?? '',
      quantity: json['quantity'] ?? 0,
      totalPrice: json['total_price'] ?? json['totalPrice'] ?? 0,
      status: json['status'] ?? '',
      trackingNumber: json['tracking_number'] ?? json['trackingNumber'],
      orderedAt: json['ordered_at'] ?? json['orderedAt'] ?? '',
      shippedAt: json['shipped_at'] ?? json['shippedAt'],
    );
  }
}

typedef PaginatedOrders = PaginatedResponse<OrderSummary>;

extension PaginatedOrdersExtension on PaginatedOrders {
  static PaginatedOrders fromJson(Map<String, dynamic> json) {
    return PaginatedResponse.fromJson(json, 'orders', OrderSummary.fromJson);
  }

  List<OrderSummary> get orders => items;
}
