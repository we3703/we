import 'package:we/core/error/result.dart';
import 'package:we/data/models/referral/referral_node.dart';
import 'package:we/data/models/referral/referral_summary.dart';

/// Referral Repository Interface
abstract class ReferralRepository {
  /// Get referral tree (hierarchy of referrals)
  Future<Result<ReferralNode>> getReferralTree();

  /// Get referral summary statistics
  Future<Result<ReferralSummary>> getReferralSummary();
}
