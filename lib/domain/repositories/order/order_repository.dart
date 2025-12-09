import 'package:we/core/error/result.dart';
import 'package:we/data/models/order/paginated_orders.dart';
import 'package:we/data/models/order/order_detail.dart';

abstract class OrderRepository {
  Future<Result<PaginatedOrders>> getMyOrders({int page = 1, int limit = 10});
  Future<Result<OrderDetail>> getOrderDetail(String orderId);
  Future<Result<void>> createOrder(Map<String, dynamic> orderData);
}
