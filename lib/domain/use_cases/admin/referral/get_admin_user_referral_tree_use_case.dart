import 'package:we/domain/entities/admin/referral/admin_referral_node_entity.dart';
import 'package:we/domain/entities/admin/referral/referral_tree_statistics_entity.dart';
import 'package:we/domain/repositories/admin/admin_referral_repository.dart';
import 'package:we/core/api/error/result.dart';

class GetAdminUserReferralTreeUseCase {
  final AdminReferralRepository _repository;

  GetAdminUserReferralTreeUseCase(this._repository);

  Future<Result<AdminReferralNodeEntity>> call(String userId) async {
    final result = await _repository.getAdminUserReferralTree(userId);
    return result.when(
      success: (adminReferralNode) {
        final childrenEntities = adminReferralNode.children
            .map(
              (node) => AdminReferralNodeEntity(
                userId: node.userId,
                name: node.name,
                email: node.email,
                level: node.level,
                joinedAt: node.joinedAt,
                totalPurchase: node.totalPurchase,
                totalCommissionGenerated: node.totalCommissionGenerated,
                children: [],
              ),
            )
            .toList();

        ReferralTreeStatisticsEntity? statisticsEntity;
        if (adminReferralNode.statistics != null) {
          statisticsEntity = ReferralTreeStatisticsEntity(
            totalMembers: adminReferralNode.statistics!.totalMembers,
            totalDepth: adminReferralNode.statistics!.totalDepth,
            totalPurchase: adminReferralNode.statistics!.totalPurchase,
            totalCommission: adminReferralNode.statistics!.totalCommission,
          );
        }

        return Result.success(
          AdminReferralNodeEntity(
            userId: adminReferralNode.userId,
            name: adminReferralNode.name,
            email: adminReferralNode.email,
            level: adminReferralNode.level,
            totalReferrals: adminReferralNode.totalReferrals,
            joinedAt: adminReferralNode.joinedAt,
            totalPurchase: adminReferralNode.totalPurchase,
            totalCommissionGenerated:
                adminReferralNode.totalCommissionGenerated,
            children: childrenEntities,
            statistics: statisticsEntity,
          ),
        );
      },
      failure: (error) {
        return Result.failure(error);
      },
    );
  }
}
