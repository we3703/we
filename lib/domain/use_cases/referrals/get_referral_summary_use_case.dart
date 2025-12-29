import 'package:we/core/api/error/result.dart';
import 'package:we/domain/entities/referral/referral_entity.dart';
import 'package:we/domain/entities/referral/referral_summary_entity.dart';
import 'package:we/domain/repositories/referrals/referral_repository.dart';

class GetReferralSummaryUseCase {
  final ReferralRepository _repository;

  GetReferralSummaryUseCase(this._repository);

  Future<Result<ReferralSummaryEntity>> call() async {
    final result = await _repository.getReferralSummary();
    return result.when(
      success: (referralSummary) {
        final referralEntities = referralSummary.referrals
            .map(
              (referral) => ReferralEntity(
                userId: referral.userId,
                name: referral.name,
                level: referral.level,
                joinedAt: referral.joinedAt,
                totalPurchase: referral.totalPurchase,
                subReferrals: referral.subReferrals,
              ),
            )
            .toList();

        return Result.success(
          ReferralSummaryEntity(
            totalReferrals: referralSummary.totalReferrals,
            directReferrals: referralSummary.directReferrals,
            indirectReferrals: referralSummary.indirectReferrals,
            totalCommission: referralSummary.totalCommission,
            referrals: referralEntities,
          ),
        );
      },
      failure: (error) {
        return Result.failure(error);
      },
    );
  }
}
