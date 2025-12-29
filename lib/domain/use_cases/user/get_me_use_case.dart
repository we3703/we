import 'package:we/core/api/error/result.dart';
import 'package:we/domain/entities/user/my_info_entity.dart';
import 'package:we/domain/repositories/user/user_repository.dart';

class GetMeUseCase {
  final UserRepository _repository;

  GetMeUseCase(this._repository);

  Future<Result<MyInfoEntity>> call() async {
    final result = await _repository.getMe();
    return result.when(
      success: (myInfo) {
        return Result.success(
          MyInfoEntity(
            userId: myInfo.userId,
            name: myInfo.name,
            phone: myInfo.phone,
            points: myInfo.points,
            level: myInfo.level,
            referrerId: myInfo.referrerId,
            referrerName: myInfo.referrerName,
            totalReferrals: myInfo.totalReferrals,
            createdAt: myInfo.createdAt,
          ),
        );
      },
      failure: (error) {
        return Result.failure(error);
      },
    );
  }
}
