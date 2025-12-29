import 'package:we/core/api/error/result.dart';
import 'package:we/data/models/order/paginated_orders.dart';
import 'package:we/domain/repositories/order/order_repository.dart';

class GetMyOrdersUseCase {
  final OrderRepository _repository;

  GetMyOrdersUseCase(this._repository);

  Future<Result<PaginatedOrders>> call({int page = 1, int limit = 10}) async {
    return await _repository.getMyOrders(page: page, limit: limit);
  }
}
