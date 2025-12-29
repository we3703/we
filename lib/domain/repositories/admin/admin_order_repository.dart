import 'package:we/core/api/error/result.dart';
import 'package:we/data/models/admin/order/paginated_admin_orders.dart';

/// Admin Order Repository Interface
abstract class AdminOrderRepository {
  /// Get paginated list of all orders (Admin only)
  Future<Result<PaginatedAdminOrders>> getAdminOrders();
}
