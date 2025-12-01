import 'shipping_address.dart';

class CreateOrderResponse {
  final String orderId;
  final String productId;
  final String productName;
  final int quantity;
  final int totalPrice;
  final int pointsUsed;
  final int remainingPoints;
  final String status;
  final ShippingAddress shippingAddress;
  final String orderedAt;

  CreateOrderResponse({
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.totalPrice,
    required this.pointsUsed,
    required this.remainingPoints,
    required this.status,
    required this.shippingAddress,
    required this.orderedAt,
  });

  factory CreateOrderResponse.fromJson(Map<String, dynamic> json) {
    return CreateOrderResponse(
      orderId: json['orderId'],
      productId: json['productId'],
      productName: json['productName'],
      quantity: json['quantity'],
      totalPrice: json['totalPrice'],
      pointsUsed: json['pointsUsed'],
      remainingPoints: json['remainingPoints'],
      status: json['status'],
      shippingAddress: ShippingAddress.fromJson(json['shippingAddress']),
      orderedAt: json['orderedAt'],
    );
  }
}
