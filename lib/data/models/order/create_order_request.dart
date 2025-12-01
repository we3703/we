import 'shipping_address.dart';

class CreateOrderRequest {
  final int productId;
  final int quantity;
  final ShippingAddress shippingAddress;

  CreateOrderRequest({
    required this.productId,
    required this.quantity,
    required this.shippingAddress,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
      'shippingAddress': shippingAddress.toJson(),
    };
  }
}
