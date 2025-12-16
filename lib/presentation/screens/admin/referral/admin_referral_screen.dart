import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/core/utils/toast_service.dart';
import 'package:we/domain/entities/admin/referral/admin_referral_node_entity.dart';
import 'package:we/presentation/atoms/buttons/primary_button.dart';
import 'package:we/presentation/atoms/inputs/text_input.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/screens/admin/referral/admin_referral_view_model.dart';

class AdminReferralScreen extends StatefulWidget {
  const AdminReferralScreen({super.key});

  @override
  State<AdminReferralScreen> createState() => _AdminReferralScreenState();
}

class _AdminReferralScreenState extends State<AdminReferralScreen> {
  final TextEditingController _userIdController = TextEditingController();

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
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

  void _loadReferralTree() {
    if (_userIdController.text.trim().isEmpty) {
      ToastService.showError('사용자 ID를 입력해주세요');
      return;
    }

    context.read<AdminReferralViewModel>().getAdminUserReferralTree(
      _userIdController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.layoutPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: TextInput(
                  controller: _userIdController,
                  hintText: '사용자 ID를 입력하세요',
                  labelText: '사용자 ID',
                  isRequired: true,
                ),
              ),
              const SizedBox(width: AppSpacing.space12),
              PrimaryButton(
                text: '조회',
                onPressed: _loadReferralTree,
                icon: Icons.search,
              ),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: Consumer<AdminReferralViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (viewModel.errorMessage != null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: AppColors.error.withValues(alpha: 0.5),
                      ),
                      const SizedBox(height: AppSpacing.space20),
                      Text(
                        viewModel.errorMessage!,
                        style: AppTextStyles.bodyRegular.copyWith(
                          color: AppColors.error,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              if (viewModel.adminReferralTree == null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_tree_outlined,
                        size: 64,
                        color: AppColors.textDisabled.withValues(alpha: 0.5),
                      ),
                      const SizedBox(height: AppSpacing.space20),
                      Text(
                        '사용자 ID를 입력하고\n조회 버튼을 눌러주세요',
                        style: AppTextStyles.bodyRegular.copyWith(
                          color: AppColors.textDisabled,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.layoutPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (viewModel.adminReferralTree!.statistics != null) ...[
                      _buildStatisticsCard(
                        viewModel.adminReferralTree!.statistics!,
                      ),
                      const SizedBox(height: AppSpacing.space20),
                    ],
                    Text('추천인 트리', style: AppTextStyles.heading3Bold),
                    const SizedBox(height: AppSpacing.space12),
                    _buildReferralTree(viewModel.adminReferralTree!, 0),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticsCard(dynamic statistics) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.layoutPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('통계 정보', style: AppTextStyles.bodyBold),
            const SizedBox(height: AppSpacing.space12),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    '전체 추천인',
                    statistics.totalReferrals?.toString() ?? '0',
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    '트리 레벨',
                    statistics.treeDepth?.toString() ?? '0',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space12),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    '총 구매액',
                    '${(statistics.totalPurchaseAmount ?? 0).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    '총 커미션',
                    '${(statistics.totalCommission ?? 0).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space12),
      decoration: BoxDecoration(
        color: AppColors.subSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            style: AppTextStyles.bodyBold.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferralTree(AdminReferralNodeEntity node, int depth) {
    return Padding(
      padding: EdgeInsets.only(left: depth * 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            margin: const EdgeInsets.only(bottom: AppSpacing.space8),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.space12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (depth > 0) ...[
                        Icon(
                          Icons.subdirectory_arrow_right,
                          size: 20,
                          color: AppColors.textDisabled,
                        ),
                        const SizedBox(width: AppSpacing.space8),
                      ],
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    node.name,
                                    style: AppTextStyles.bodyBold,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.space8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getLevelColor(
                                      node.level,
                                    ).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    _getLevelText(node.level),
                                    style: AppTextStyles.subMedium.copyWith(
                                      color: _getLevelColor(node.level),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.space8 / 2),
                            Text(
                              node.email,
                              style: AppTextStyles.subRegular.copyWith(
                                color: AppColors.textDisabled,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.space8),
                  Row(
                    children: [
                      if (node.totalReferrals != null)
                        _buildNodeInfo('추천인', '${node.totalReferrals}명'),
                      if (node.totalPurchase != null) ...[
                        const SizedBox(width: AppSpacing.space12),
                        _buildNodeInfo(
                          '구매액',
                          '${(node.totalPurchase! ~/ 1000).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}K',
                        ),
                      ],
                      if (node.totalCommissionGenerated != null) ...[
                        const SizedBox(width: AppSpacing.space12),
                        _buildNodeInfo(
                          '커미션',
                          '${(node.totalCommissionGenerated! ~/ 1000).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}K',
                        ),
                      ],
                    ],
                  ),
                  if (node.joinedAt != null) ...[
                    const SizedBox(height: AppSpacing.space8),
                    Text(
                      '가입: ${node.joinedAt}',
                      style: AppTextStyles.subRegular.copyWith(
                        color: AppColors.textDisabled,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          ...node.children.map((child) => _buildReferralTree(child, depth + 1)),
        ],
      ),
    );
  }

  Widget _buildNodeInfo(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: AppTextStyles.subRegular.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: AppTextStyles.subBold.copyWith(color: AppColors.textPrimary),
        ),
      ],
    );
  }
}
