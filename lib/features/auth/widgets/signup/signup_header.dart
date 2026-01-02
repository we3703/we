import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:we/core/config/constant.dart';
import 'package:we/core/theme/colors.dart';
import 'package:we/core/theme/spacing.dart';
import 'package:we/core/theme/typography.dart';

class SignupHeader extends StatelessWidget {
  final VoidCallback onBackPressed;

  const SignupHeader({super.key, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Positioned.fill(
          child: ClipRRect(
            child: Image.asset(AppConstant.background, fit: BoxFit.cover),
          ),
        ),
        // Content
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.space32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                IconButton(
                  icon: SvgPicture.asset(
                    AppConstant.backIcon,
                    width: 32,
                    height: 32,
                  ),
                  onPressed: onBackPressed,
                ),
                const SizedBox(height: AppSpacing.space32),
                // Logo
                SvgPicture.asset(AppConstant.logoPath, width: 64, height: 64),
                const SizedBox(height: AppSpacing.space24),
                // Title
                Text(
                  '회원가입 후',
                  style: AppTextStyles.heading2Bold.copyWith(
                    color: AppColors.textInverse,
                  ),
                ),
                Text(
                  '헬스온을',
                  style: AppTextStyles.heading2Bold.copyWith(
                    color: AppColors.textInverse,
                  ),
                ),
                Text(
                  '이용해보세요.',
                  style: AppTextStyles.heading2Bold.copyWith(
                    color: AppColors.textInverse,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
