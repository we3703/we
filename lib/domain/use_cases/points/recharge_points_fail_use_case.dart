import 'package:we/core/error/result.dart';
import 'package:we/domain/repositories/points/points_repository.dart';

class RechargePointsFailUseCase {
  final PointsRepository _repository;

  RechargePointsFailUseCase(this._repository);

  Future<Result<void>> call() {
    return _repository.rechargePointsFail();
  }
}
