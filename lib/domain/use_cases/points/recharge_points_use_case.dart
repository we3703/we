import 'package:we/data/models/point/recharge_points_request.dart';

import 'package:we/core/error/result.dart';
import 'package:we/domain/repositories/points/points_repository.dart';

class RechargePointsUseCase {
  final PointsRepository _repository;

  RechargePointsUseCase(this._repository);

  Future<Result<void>> call(RechargePointsRequest request) {
    return _repository.rechargePoints(request);
  }
}
