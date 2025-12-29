import 'package:we/domain/repositories/admin/admin_user_repository.dart';
import 'package:we/core/api/error/result.dart';
import 'package:we/domain/entities/admin/user/admin_user_summary_entity.dart';
import 'package:we/domain/entities/admin/user/paginated_admin_users_entity.dart';
import 'package:we/domain/entities/common/paginated_response_entity.dart';

class GetAdminUsersUseCase {
  final AdminUserRepository _repository;

  GetAdminUsersUseCase(this._repository);

  Future<Result<PaginatedAdminUsersEntity>> call() async {
    final result = await _repository.getAdminUsers();
    return result.when(
      success: (paginatedAdminUsers) {
        final adminUserSummaryEntities = paginatedAdminUsers.items
            .map(
              (item) => AdminUserSummaryEntity(
                userId: item.userId,
                email: item.email,
                name: item.name,
                phone: item.phone,
                level: item.level,
                points: item.points,
                totalPurchase: item.totalPurchase,
                totalReferrals: item.totalReferrals,
                referrerId: item.referrerId,
                referrerName: item.referrerName,
                status: item.status,
                createdAt: item.createdAt,
                lastLoginAt: item.lastLoginAt,
              ),
            )
            .toList();

        return Result.success(
          PaginatedResponseEntity<AdminUserSummaryEntity>(
            totalCount: paginatedAdminUsers.totalCount,
            currentPage: paginatedAdminUsers.currentPage,
            totalPages: paginatedAdminUsers.totalPages,
            items: adminUserSummaryEntities,
            totalAmount: paginatedAdminUsers.totalAmount,
          ),
        );
      },
      failure: (error) {
        return Result.failure(error);
      },
    );
  }
}
