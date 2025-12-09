import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/shadows.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/molecules/cards/user/user_status_card.dart';
import 'package:we/presentation/molecules/cards/user/info_stat_card.dart';
import 'package:we/presentation/molecules/tab/quick_action_button.dart';
import 'package:we/presentation/molecules/tab/quick_action_group.dart';

class HomeHeaderData {
  final String name;
  final MembershipLevel membershipLevel;
  final String points;
  final String recommendationCount;

  HomeHeaderData({
    required this.name,
    required this.membershipLevel,
    required this.points,
    required this.recommendationCount,
  });
}

class HomeHeaderSection extends StatelessWidget {
  final HomeHeaderData data;
  final VoidCallback onRecommendPressed;
  final VoidCallback onChargePressed;
  final VoidCallback onPurchasePressed;

  const HomeHeaderSection({
    super.key,
    required this.data,
    required this.onRecommendPressed,
    required this.onChargePressed,
    required this.onPurchasePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // User greeting card
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: AppShadow.card,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.layoutPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '안녕하세요, ${data.name}님!',
                  style: AppTextStyles.heading3Bold,
                ),
                const SizedBox(height: 4),
                Text(
                  data.membershipLevel.displayName,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: data.membershipLevel.color,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.space12),
        // Stats using InfoStatCard
        InfoStatCard(
          title: '내 정보',
          stats: [
            InfoStatItem(title: '보유 포인트', value: data.points),
            InfoStatItem(title: '내 추천 현황', value: data.recommendationCount),
          ],
        ),
        const SizedBox(height: AppSpacing.space12),
        // Quick actions card
        Card(
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.layoutPadding),
            child: QuickActionGroup(
              actions: [
                QuickActionButton(
                  icon: Icons.recommend_outlined,
                  label: '추천',
                  onPressed: onRecommendPressed,
                ),
                QuickActionButton(
                  icon: Icons.add_card_outlined,
                  label: '충전',
                  onPressed: onChargePressed,
                ),
                QuickActionButton(
                  icon: Icons.shopping_cart_outlined,
                  label: '구매',
                  onPressed: onPurchasePressed,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
