import 'package:we/data/models/user/update_my_info_request.dart';
import 'package:we/domain/entities/user/my_info_entity.dart';
import 'package:we/domain/entities/user/update_my_info_entity.dart';
import 'package:we/domain/entities/user/user_entity.dart';
import 'package:we/domain/use_cases/user/get_me_use_case.dart';
import 'package:we/domain/use_cases/user/update_me_use_case.dart';
import 'package:we/presentation/base/base_view_model.dart';

class UserViewModel extends BaseViewModel {
  final GetMeUseCase _getMeUseCase;
  final UpdateMeUseCase _updateMeUseCase;

  UserViewModel(this._getMeUseCase, this._updateMeUseCase);

  MyInfoEntity? _myInfo;
  MyInfoEntity? get myInfo => _myInfo;

  UpdateMyInfoEntity? _updatedMyInfo;
  UpdateMyInfoEntity? get updatedMyInfo => _updatedMyInfo;

  /// Set user info from login response (UserEntity -> MyInfoEntity)
  void setUserFromLogin(UserEntity userEntity) {
    _myInfo = MyInfoEntity(
      userId: userEntity.userId,
      name: userEntity.name,
      phone: userEntity.phone,
      points: userEntity.points ?? 0,
      level: userEntity.level ?? '',
      referrerId: userEntity.referrerId,
      referrerName: userEntity.referrerName,
      totalReferrals: userEntity.totalReferrals ?? 0,
      createdAt: userEntity.createdAt ?? '',
    );
    notifyListeners();
  }

  Future<void> getMe() async {
    setLoading(true);
    clearError();

    final result = await _getMeUseCase();

    result.when(
      success: (myInfoEntity) {
        _myInfo = myInfoEntity;
        notifyListeners();
      },
      failure: (failure) {
        setError(mapFailureToMessage(failure));
        _myInfo = null;
      },
    );

    setLoading(false);
  }

  Future<void> updateMe(UpdateMyInfoRequest request) async {
    setLoading(true);
    clearError();

    final result = await _updateMeUseCase(request);

    result.when(
      success: (updateMyInfoEntity) {
        _updatedMyInfo = updateMyInfoEntity;
        notifyListeners();
        getMe();
      },
      failure: (failure) {
        setError(mapFailureToMessage(failure));
        _updatedMyInfo = null;
      },
    );

    setLoading(false);
  }

  void reset() {
    _myInfo = null;
    _updatedMyInfo = null;
    notifyListeners();
  }
}
