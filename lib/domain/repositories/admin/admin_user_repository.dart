import 'package:we/core/error/result.dart';
import 'package:we/data/models/admin/user/paginated_admin_users.dart';

/// Admin User Repository Interface
abstract class AdminUserRepository {
  /// Get paginated list of all users (Admin only)
  Future<Result<PaginatedAdminUsers>> getAdminUsers();
}
