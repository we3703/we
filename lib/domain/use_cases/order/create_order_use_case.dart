import 'package:we/core/api/error/result.dart';
import 'package:we/domain/repositories/order/order_repository.dart';

class CreateOrderUseCase {
  final OrderRepository repository;

  CreateOrderUseCase(this.repository);

  Future<Result<void>> call(Map<String, dynamic> orderData) async {
    return await repository.createOrder(orderData);
  }
}
