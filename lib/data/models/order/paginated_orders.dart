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
      orderId: json['orderId'],
      productId: json['productId'],
      productName: json['productName'],
      productImage: json['productImage'],
      quantity: json['quantity'],
      totalPrice: json['totalPrice'],
      status: json['status'],
      trackingNumber: json['trackingNumber'],
      orderedAt: json['orderedAt'],
      shippedAt: json['shippedAt'],
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
