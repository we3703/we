import 'package:we/core/api/error/result.dart';
import 'package:we/domain/entities/point/point_history_item_entity.dart';
import 'package:we/domain/entities/point/points_history_entity.dart';
import 'package:we/domain/repositories/points/points_repository.dart';

class GetPointsHistoryUseCase {
  final PointsRepository _repository;

  GetPointsHistoryUseCase(this._repository);

  Future<Result<PointsHistoryEntity>> call() async {
    final result = await _repository.getPointsHistory();
    return result.when(
      success: (pointsHistory) {
        final historyItemEntities = pointsHistory.history
            .map(
              (item) => PointHistoryItemEntity(
                historyId: item.historyId,
                type: item.type,
                amount: item.amount,
                balance: item.balance,
                description: item.description,
                orderId: item.orderId,
                fromUserId: item.fromUserId,
                createdAt: item.createdAt,
              ),
            )
            .toList();

        return Result.success(
          PointsHistoryEntity(
            currentPoints: pointsHistory.currentPoints,
            totalCharged: pointsHistory.totalCharged,
            totalUsed: pointsHistory.totalUsed,
            totalCommission: pointsHistory.totalCommission,
            history: historyItemEntities,
          ),
        );
      },
      failure: (error) {
        return Result.failure(error);
      },
    );
  }
}
