import 'package:we/core/error/result.dart';
import 'package:we/data/models/point/paginated_recharge_history.dart';
import 'package:we/data/models/point/points_history.dart';
import 'package:we/data/models/point/recharge_points_request.dart';

/// Points Repository Interface
abstract class PointsRepository {
  /// Recharge points
  Future<Result<void>> rechargePoints(RechargePointsRequest request);

  /// Handle recharge success callback
  Future<Result<void>> rechargePointsSuccess();

  /// Handle recharge failure callback
  Future<Result<void>> rechargePointsFail();

  /// Get recharge history with pagination
  Future<Result<PaginatedRechargeHistory>> getRechargeHistory();

  /// Get points usage history
  Future<Result<PointsHistory>> getPointsHistory();
}
