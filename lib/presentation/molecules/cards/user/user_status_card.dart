import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/shadows.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/foundations/icon_radio.dart'; // For AppIcon
import 'package:we/presentation/foundations/spacing.dart';

enum MembershipLevel { bronze, silver, gold, diamond, master, none }

extension MembershipLevelExtension on MembershipLevel {
  Color get color {
    switch (this) {
      case MembershipLevel.bronze:
        return AppColors.bronze;
      case MembershipLevel.silver:
        return AppColors.silver;
      case MembershipLevel.gold:
        return AppColors.gold;
      case MembershipLevel.diamond:
        return AppColors.diamond;
      case MembershipLevel.master:
        return AppColors.master;
      case MembershipLevel.none:
        return AppColors.textDisabled; // Default for no level
    }
  }

  String get displayName {
    switch (this) {
      case MembershipLevel.bronze:
        return 'Bronze';
      case MembershipLevel.silver:
        return 'Silver';
      case MembershipLevel.gold:
        return 'Gold';
      case MembershipLevel.diamond:
        return 'Diamond';
      case MembershipLevel.master:
        return 'Master';
      case MembershipLevel.none:
        return 'Member';
    }
  }
}

class UserStatusCard extends StatelessWidget {
  final String userName;
  final MembershipLevel membershipLevel;
  final String? joinDate;
  final int? recommendationCount;
  final String? profileImageUrl;

  const UserStatusCard({
    super.key,
    required this.userName,
    this.membershipLevel = MembershipLevel.none,
    this.joinDate,
    this.recommendationCount,
    this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: AppShadow.card,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.layoutPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Profile Image/Icon
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.secondaryLight,
              foregroundImage: profileImageUrl != null
                  ? NetworkImage(profileImageUrl!)
                  : null,
              child: profileImageUrl == null
                  ? AppIcon.size32(
                      icon: Icons.person,
                      color: AppColors.textDisabled,
                    )
                  : null,
            ),
            const SizedBox(width: AppSpacing.layoutPadding),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  userName,
                  style: AppTextStyles.bodyBold.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (membershipLevel != MembershipLevel.none) ...[
                      Text(
                        membershipLevel.displayName,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: membershipLevel.color,
                        ),
                      ),
                      const SizedBox(width: 4),
                    ],
                    Text(
                      'Member',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textDisabled,
                      ),
                    ),
                  ],
                ),
                if (joinDate != null || recommendationCount != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _buildAdditionalInfo(),
                    style: AppTextStyles.bodyRegular.copyWith(
                      color: AppColors.textDisabled,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _buildAdditionalInfo() {
    String info = '';
    if (joinDate != null) {
      info += '가입일 $joinDate';
    }
    if (recommendationCount != null) {
      if (info.isNotEmpty) info += ' ';
      info += '추천 수 $recommendationCount';
    }
    return info;
  }
}
