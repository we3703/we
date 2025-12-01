import 'package:we/core/error/result.dart';
import 'package:we/domain/repositories/points/points_repository.dart';

class RechargePointsSuccessUseCase {
  final PointsRepository _repository;

  RechargePointsSuccessUseCase(this._repository);

  Future<Result<void>> call() {
    return _repository.rechargePointsSuccess();
  }
}
