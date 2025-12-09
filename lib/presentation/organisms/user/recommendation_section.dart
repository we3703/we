import 'package:flutter/material.dart';
import 'package:we/presentation/atoms/buttons/primary_button.dart';
import 'package:we/presentation/atoms/buttons/secondary_button.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/molecules/cards/user/info_stat_card.dart';
import 'package:we/presentation/molecules/cards/user/user_status_card.dart';
import 'package:we/presentation/screens/referral/referral_tree_screen.dart';

// Data model for recommendation statistics
class RecommendationStatsData {
  final String totalRecommendations;
  final String directRecommendations;
  final String indirectRecommendations;

  RecommendationStatsData({
    required this.totalRecommendations,
    required this.directRecommendations,
    required this.indirectRecommendations,
  });
}

// Data model for a recommended user
class RecommendedUserData {
  final String name;
  final MembershipLevel membershipLevel;
  final String? joinDate;
  final int? recommendationCount;
  final String? profileImageUrl;

  RecommendedUserData({
    required this.name,
    required this.membershipLevel,
    this.joinDate,
    this.recommendationCount,
    this.profileImageUrl,
  });
}

class RecommendationSection extends StatelessWidget {
  final RecommendationStatsData stats;
  final VoidCallback onCopyLinkPressed;
  final List<RecommendedUserData> recommendedUsers;

  const RecommendationSection({
    super.key,
    required this.stats,
    required this.onCopyLinkPressed,
    required this.recommendedUsers,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Recommendation Stats Card
        InfoStatCard(
          title: '추천 통계', // "Recommendation Stats"
          stats: [
            InfoStatItem(
              title: '총 추천',
              value: stats.totalRecommendations,
            ), // "Total Recommendations"
            InfoStatItem(
              title: '직접 추천 1단계',
              value: stats.directRecommendations,
            ), // "Direct L1 Recommendations"
            InfoStatItem(
              title: '간접 추천 2단계',
              value: stats.indirectRecommendations,
            ), // "Indirect L2 Recommendations"
          ],
        ),
        const SizedBox(height: AppSpacing.space20),
        // Copy Referral Link Button & View Tree Button
        Row(
          children: [
            Expanded(
              child: PrimaryButton(
                text: '내 추천링크 복사', // "Copy My Referral Link"
                onPressed: onCopyLinkPressed,
              ),
            ),
            const SizedBox(width: AppSpacing.space8),
            Expanded(
              child: SecondaryButton(
                text: '추천트리 확인', // "View Referral Tree"
                onPressed: () {
                  Navigator.of(context).pushNamed(ReferralTreeScreen.routeName);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.space32),
        // Recommended Users List
        Text(
          '내가 추천한 사람', // "People I've recommended"
          style:
              AppTextStyles.heading3Bold, // Using AppTextStyles for consistency
        ),
        const SizedBox(height: AppSpacing.space12),
        if (recommendedUsers.isEmpty)
          const Text('추천한 사람이 없습니다.')
        else
          ...recommendedUsers.asMap().entries.map((entry) {
            final index = entry.key;
            final user = entry.value;
            return Column(
              children: [
                UserStatusCard(
                  userName: user.name,
                  membershipLevel: user.membershipLevel,
                  joinDate: user.joinDate,
                  recommendationCount: user.recommendationCount,
                  profileImageUrl: user.profileImageUrl,
                ),
                if (index < recommendedUsers.length - 1)
                  const SizedBox(height: AppSpacing.space12),
              ],
            );
          }),
      ],
    );
  }
}
