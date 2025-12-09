import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/domain/entities/admin/user/admin_user_summary_entity.dart';
import 'package:we/presentation/atoms/buttons/primary_button.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/molecules/appbar/app_header.dart';
import 'package:we/presentation/screens/admin/user/admin_user_view_model.dart';

class AdminUserScreen extends StatefulWidget {
  const AdminUserScreen({super.key});

  @override
  State<AdminUserScreen> createState() => _AdminUserScreenState();
}

class _AdminUserScreenState extends State<AdminUserScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminUserViewModel>().getAdminUsers();
    });
  }

  Color _getLevelColor(String level) {
    switch (level.toLowerCase()) {
      case 'bronze':
        return AppColors.bronze;
      case 'silver':
        return AppColors.silver;
      case 'gold':
        return AppColors.gold;
      case 'diamond':
        return AppColors.diamond;
      case 'master':
        return AppColors.master;
      default:
        return AppColors.textDisabled;
    }
  }

  String _getLevelText(String level) {
    switch (level.toLowerCase()) {
      case 'bronze':
        return '브론즈';
      case 'silver':
        return '실버';
      case 'gold':
        return '골드';
      case 'diamond':
        return '다이아몬드';
      case 'master':
        return '마스터';
      default:
        return level;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return AppColors.silver;
      case 'inactive':
        return AppColors.secondary;
      case 'suspended':
        return AppColors.error;
      default:
        return AppColors.textDisabled;
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return '활성';
      case 'inactive':
        return '비활성';
      case 'suspended':
        return '정지';
      default:
        return status;
    }
  }

  void _showUserDetailDialog(AdminUserSummaryEntity user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('사용자 상세', style: AppTextStyles.heading3Bold),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('사용자 ID', user.userId),
              const Divider(),
              _buildDetailRow('이름', user.name),
              _buildDetailRow('이메일', user.email),
              if (user.phone != null) _buildDetailRow('전화번호', user.phone!),
              const Divider(),
              _buildDetailRow('레벨', _getLevelText(user.level)),
              _buildDetailRow('상태', _getStatusText(user.status)),
              const Divider(),
              _buildDetailRow(
                '보유 포인트',
                '${user.points.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}P',
              ),
              _buildDetailRow(
                '총 구매액',
                '${user.totalPurchase.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
              ),
              _buildDetailRow('총 추천인 수', '${user.totalReferrals}명'),
              const Divider(),
              if (user.referrerName != null)
                _buildDetailRow(
                  '추천인',
                  '${user.referrerName} (${user.referrerId})',
                ),
              _buildDetailRow('가입일', user.createdAt),
              if (user.lastLoginAt != null)
                _buildDetailRow('최근 접속', user.lastLoginAt!),
            ],
          ),
        ),
        actions: [
          PrimaryButton(text: '닫기', onPressed: () => Navigator.pop(context)),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.space8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: AppTextStyles.subMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.subRegular.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: '사용자 관리', showBackButton: true),
      body: Consumer<AdminUserViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    viewModel.errorMessage!,
                    style: AppTextStyles.bodyRegular.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space20),
                  PrimaryButton(
                    text: '다시 시도',
                    onPressed: () => viewModel.getAdminUsers(),
                  ),
                ],
              ),
            );
          }

          final paginatedUsers = viewModel.paginatedAdminUsers;
          final users = paginatedUsers?.items ?? [];

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.layoutPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '총 ${paginatedUsers?.totalCount ?? 0}명',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    if (paginatedUsers != null)
                      Text(
                        '페이지 ${paginatedUsers.currentPage}/${paginatedUsers.totalPages}',
                        style: AppTextStyles.subRegular.copyWith(
                          color: AppColors.textDisabled,
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: users.isEmpty
                    ? Center(
                        child: Text(
                          '사용자가 없습니다',
                          style: AppTextStyles.bodyRegular.copyWith(
                            color: AppColors.textDisabled,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.layoutPadding,
                        ),
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          return Card(
                            margin: const EdgeInsets.only(
                              bottom: AppSpacing.space12,
                            ),
                            child: InkWell(
                              onTap: () => _showUserDetailDialog(user),
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                  AppSpacing.layoutPadding,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                user.name,
                                                style: AppTextStyles.bodyBold,
                                              ),
                                              const SizedBox(
                                                height: AppSpacing.space8 / 2,
                                              ),
                                              Text(
                                                user.email,
                                                style: AppTextStyles.subRegular
                                                    .copyWith(
                                                      color: AppColors
                                                          .textDisabled,
                                                    ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: AppSpacing.space8,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal:
                                                        AppSpacing.space8,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: _getLevelColor(
                                                  user.level,
                                                ).withValues(alpha: 0.1),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                _getLevelText(user.level),
                                                style: AppTextStyles.subMedium
                                                    .copyWith(
                                                      color: _getLevelColor(
                                                        user.level,
                                                      ),
                                                    ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: AppSpacing.space8 / 2,
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal:
                                                        AppSpacing.space8,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: _getStatusColor(
                                                  user.status,
                                                ).withValues(alpha: 0.1),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                _getStatusText(user.status),
                                                style: AppTextStyles.subMedium
                                                    .copyWith(
                                                      color: _getStatusColor(
                                                        user.status,
                                                      ),
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: AppSpacing.space12),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _buildInfoChip(
                                            '포인트',
                                            '${user.points.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}P',
                                          ),
                                        ),
                                        const SizedBox(
                                          width: AppSpacing.space8,
                                        ),
                                        Expanded(
                                          child: _buildInfoChip(
                                            '구매액',
                                            '${(user.totalPurchase ~/ 1000).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}K',
                                          ),
                                        ),
                                        const SizedBox(
                                          width: AppSpacing.space8,
                                        ),
                                        Expanded(
                                          child: _buildInfoChip(
                                            '추천',
                                            '${user.totalReferrals}명',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: AppSpacing.space8),
                                    Text(
                                      '가입: ${user.createdAt}',
                                      style: AppTextStyles.subRegular.copyWith(
                                        color: AppColors.textDisabled,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space8,
        vertical: AppSpacing.space8,
      ),
      decoration: BoxDecoration(
        color: AppColors.subSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: AppTextStyles.subRegular.copyWith(
              color: AppColors.textDisabled,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.subBold.copyWith(color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
