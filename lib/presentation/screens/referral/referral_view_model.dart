import 'package:we/domain/entities/referral/referral_node_entity.dart';
import 'package:we/domain/entities/referral/referral_summary_entity.dart';
import 'package:we/domain/use_cases/referrals/get_referral_summary_use_case.dart';
import 'package:we/domain/use_cases/referrals/get_referral_tree_use_case.dart';
import 'package:we/presentation/base/base_view_model.dart';

class ReferralViewModel extends BaseViewModel {
  final GetReferralTreeUseCase _getReferralTreeUseCase;
  final GetReferralSummaryUseCase _getReferralSummaryUseCase;

  ReferralViewModel(
    this._getReferralTreeUseCase,
    this._getReferralSummaryUseCase,
  );

  ReferralNodeEntity? _referralTree;
  ReferralNodeEntity? get referralTree => _referralTree;

  ReferralSummaryEntity? _referralSummary;
  ReferralSummaryEntity? get referralSummary => _referralSummary;

  Future<void> getReferralTree() async {
    setLoading(true);
    clearError();

    final result = await _getReferralTreeUseCase();

    result.when(
      success: (data) {
        print('🌳 ReferralViewModel.getReferralTree() SUCCESS');
        print('  - Tree data: $data');
        _referralTree = data;
        setError(null);
      },
      failure: (failure) {
        print('❌ ReferralViewModel.getReferralTree() FAILURE: ${mapFailureToMessage(failure)}');
        setError(mapFailureToMessage(failure));
        _referralTree = null;
      },
    );

    setLoading(false);
  }

  Future<void> getReferralSummary() async {
    setLoading(true);
    clearError();

    final result = await _getReferralSummaryUseCase();

    result.when(
      success: (data) {
        print('📊 ReferralViewModel.getReferralSummary() SUCCESS');
        print('  - Total referrals: ${data.totalReferrals}');
        print('  - Direct referrals: ${data.directReferrals}');
        print('  - Indirect referrals: ${data.indirectReferrals}');
        print('  - Referrals count: ${data.referrals.length}');
        for (var i = 0; i < data.referrals.length; i++) {
          final ref = data.referrals[i];
          print('  - Referral[$i]: name=${ref.name}, level=${ref.level}, joinedAt=${ref.joinedAt}, subReferrals=${ref.subReferrals}');
        }
        _referralSummary = data;
        setError(null);
      },
      failure: (failure) {
        print('❌ ReferralViewModel.getReferralSummary() FAILURE: ${mapFailureToMessage(failure)}');
        setError(mapFailureToMessage(failure));
        _referralSummary = null;
      },
    );

    setLoading(false);
  }
}
