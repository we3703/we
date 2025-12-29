import 'package:we/domain/repositories/admin/admin_order_repository.dart';
import 'package:we/core/api/error/result.dart';
import 'package:we/domain/entities/admin/order/admin_order_summary_entity.dart';
import 'package:we/domain/entities/admin/order/paginated_admin_orders_entity.dart';
import 'package:we/domain/entities/admin/order/user_in_admin_order_entity.dart';
import 'package:we/domain/entities/common/paginated_response_entity.dart';
import 'package:we/domain/entities/common/product_info_entity.dart';

class GetAdminOrdersUseCase {
  final AdminOrderRepository _repository;

  GetAdminOrdersUseCase(this._repository);

  Future<Result<PaginatedAdminOrdersEntity>> call() async {
    final result = await _repository.getAdminOrders();
    return result.when(
      success: (paginatedAdminOrders) {
        final adminOrderSummaryEntities = paginatedAdminOrders.items
            .map(
              (item) => AdminOrderSummaryEntity(
                orderId: item.orderId,
                user: UserInAdminOrderEntity(
                  userId: item.user.userId,
                  name: item.user.name,
                  email: item.user.email,
                  level: item.user.level,
                ),
                product: ProductInfoEntity(
                  productId: item.product.productId,
                  name: item.product.name,
                  image: item.product.image,
                  price: item.product.price,
                ),
                quantity: item.quantity,
                totalPrice: item.totalPrice,
                status: item.status,
                trackingNumber: item.trackingNumber,
                orderedAt: item.orderedAt,
                shippedAt: item.shippedAt,
              ),
            )
            .toList();

        return Result.success(
          PaginatedResponseEntity<AdminOrderSummaryEntity>(
            totalCount: paginatedAdminOrders.totalCount,
            currentPage: paginatedAdminOrders.currentPage,
            totalPages: paginatedAdminOrders.totalPages,
            items: adminOrderSummaryEntities,
            totalAmount: paginatedAdminOrders.totalAmount,
          ),
        );
      },
      failure: (error) {
        return Result.failure(error);
      },
    );
  }
}
