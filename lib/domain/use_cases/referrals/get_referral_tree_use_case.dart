import 'package:we/core/error/result.dart';
import 'package:we/domain/entities/referral/referral_node_entity.dart';
import 'package:we/domain/repositories/referrals/referral_repository.dart';

class GetReferralTreeUseCase {
  final ReferralRepository _repository;

  GetReferralTreeUseCase(this._repository);

  Future<Result<ReferralNodeEntity>> call() async {
    final result = await _repository.getReferralTree();
    return result.when(
      success: (referralNode) {
        final childrenEntities = referralNode.children
            .map(
              (node) => ReferralNodeEntity(
                userId: node.userId,
                name: node.name,
                level: node.level,
                joinedAt: node.joinedAt,
                children: [], // Children will be mapped recursively if needed
              ),
            )
            .toList();

        return Result.success(
          ReferralNodeEntity(
            userId: referralNode.userId,
            name: referralNode.name,
            level: referralNode.level,
            joinedAt: referralNode.joinedAt,
            children: childrenEntities,
          ),
        );
      },
      failure: (error) {
        return Result.failure(error);
      },
    );
  }
}
