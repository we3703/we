import 'package:we/core/api/error/result.dart';
import 'package:we/domain/entities/common/paginated_response_entity.dart';
import 'package:we/domain/entities/point/paginated_recharge_history_entity.dart';
import 'package:we/domain/entities/point/recharge_history_item_entity.dart';
import 'package:we/domain/repositories/points/points_repository.dart';

class GetRechargeHistoryUseCase {
  final PointsRepository _repository;

  GetRechargeHistoryUseCase(this._repository);

  Future<Result<PaginatedRechargeHistoryEntity>> call() async {
    final result = await _repository.getRechargeHistory();
    return result.when(
      success: (paginatedHistory) {
        final historyItemEntities = paginatedHistory.items
            .map(
              (item) => RechargeHistoryItemEntity(
                rechargeId: item.rechargeId,
                amount: item.amount,
                status: item.status,
                paymentMethod: item.paymentMethod,
                requestedAt: item.requestedAt,
                approvedAt: item.approvedAt,
              ),
            )
            .toList();

        final paginatedHistoryEntity =
            PaginatedResponseEntity<RechargeHistoryItemEntity>(
              totalCount: paginatedHistory.totalCount,
              currentPage: paginatedHistory.currentPage,
              totalPages: paginatedHistory.totalPages,
              items: historyItemEntities,
            );

        return Result.success(paginatedHistoryEntity);
      },
      failure: (error) {
        return Result.failure(error);
      },
    );
  }
}
