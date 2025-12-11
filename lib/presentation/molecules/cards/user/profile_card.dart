import 'package:flutter/material.dart';
import 'package:we/core/utils/membership_level.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/foundations/icon_radio.dart';
import 'package:we/presentation/foundations/spacing.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final MembershipLevel membershipLevel;
  final String? profileImageUrl;
  final String? joinDate;

  const ProfileCard({
    super.key,
    required this.name,
    required this.membershipLevel,
    this.profileImageUrl,
    this.joinDate, // e.g., "가입 날짜 2025.11.16"
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.layoutPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Image/Icon
          CircleAvatar(
            radius: 40, // Larger size
            backgroundColor: AppColors.secondaryLight,
            foregroundImage: profileImageUrl != null
                ? NetworkImage(profileImageUrl!)
                : null,
            child: profileImageUrl == null
                ? AppIcon.size40(
                    icon: Icons.person,
                    color: AppColors.textDisabled,
                  )
                : null,
          ),
          const SizedBox(height: AppSpacing.layoutPadding),
          Text(
            name,
            style: AppTextStyles.heading3Bold.copyWith(
              color: AppColors.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          if (joinDate != null) ...[
            const SizedBox(height: 8),
            Text(
              joinDate!,
              style: AppTextStyles.bodyRegular.copyWith(
                color: AppColors.textDisabled,
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}
