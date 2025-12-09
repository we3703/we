import 'package:we/core/error/result.dart';
import 'package:we/data/models/point/recharge_points_request.dart';
import 'package:we/domain/entities/point/paginated_recharge_history_entity.dart';
import 'package:we/domain/entities/point/points_history_entity.dart';
import 'package:we/domain/use_cases/points/get_points_history_use_case.dart';
import 'package:we/domain/use_cases/points/get_recharge_history_use_case.dart';
import 'package:we/domain/use_cases/points/recharge_points_fail_use_case.dart';
import 'package:we/domain/use_cases/points/recharge_points_use_case.dart';
import 'package:we/domain/use_cases/points/recharge_points_success_use_case.dart';
import 'package:we/presentation/base/base_view_model.dart';

class PointsViewModel extends BaseViewModel {
  final RechargePointsUseCase _rechargePointsUseCase;
  final RechargePointsSuccessUseCase _rechargePointsSuccessUseCase;
  final RechargePointsFailUseCase _rechargePointsFailUseCase;
  final GetRechargeHistoryUseCase _getRechargeHistoryUseCase;
  final GetPointsHistoryUseCase _getPointsHistoryUseCase;
  PointsViewModel(
    this._rechargePointsUseCase,
    this._rechargePointsSuccessUseCase,
    this._rechargePointsFailUseCase,
    this._getRechargeHistoryUseCase,
    this._getPointsHistoryUseCase,
  );
  PaginatedRechargeHistoryEntity? _rechargeHistory;
  PaginatedRechargeHistoryEntity? get rechargeHistory => _rechargeHistory;

  PointsHistoryEntity? _pointsHistory;
  PointsHistoryEntity? get pointsHistory => _pointsHistory;

  Future<Result<void>> rechargePoints(RechargePointsRequest request) async {
    setLoading(true);
    clearError();

    final result = await _rechargePointsUseCase(request);

    result.when(
      success: (_) {
        setError(null);
        getPointsHistory();
      },
      failure: (failure) {
        setError(mapFailureToMessage(failure));
      },
    );

    setLoading(false);
    return result;
  }

  Future<void> rechargePointsSuccess() async {
    setLoading(true);
    clearError();

    final result = await _rechargePointsSuccessUseCase();

    result.when(
      success: (_) {
        setError(null);
        getPointsHistory();
      },
      failure: (failure) {
        setError(mapFailureToMessage(failure));
      },
    );

    setLoading(false);
  }

  Future<void> rechargePointsFail() async {
    setLoading(true);
    clearError();

    final result = await _rechargePointsFailUseCase();

    result.when(
      success: (_) {
        setError(null);
      },
      failure: (failure) {
        setError(mapFailureToMessage(failure));
      },
    );

    setLoading(false);
  }

  Future<void> getRechargeHistory() async {
    setLoading(true);
    clearError();

    final result = await _getRechargeHistoryUseCase();

    result.when(
      success: (data) {
        _rechargeHistory = data;
        setError(null);
      },
      failure: (failure) {
        setError(mapFailureToMessage(failure));
        _rechargeHistory = null;
      },
    );

    setLoading(false);
  }

  Future<void> getPointsHistory() async {
    setLoading(true);
    clearError();

    final result = await _getPointsHistoryUseCase();

    result.when(
      success: (data) {
        _pointsHistory = data;
        setError(null);
      },
      failure: (failure) {
        setError(mapFailureToMessage(failure));
        _pointsHistory = null;
      },
    );

    setLoading(false);
  }
}
