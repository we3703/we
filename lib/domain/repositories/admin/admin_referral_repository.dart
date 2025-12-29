import 'package:we/core/api/error/result.dart';
import 'package:we/data/models/admin/referral/admin_referral_node.dart';

/// Admin Referral Repository Interface
abstract class AdminReferralRepository {
  /// Get referral tree for specific user (Admin only)
  Future<Result<AdminReferralNode>> getAdminUserReferralTree(String userId);
}
