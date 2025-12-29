import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/core/utils/membership_level.dart';
import 'package:we/core/utils/toast_service.dart';
import 'package:we/domain/use_cases/auth/logout_use_case.dart';
import 'package:we/features/auth/screen/login_screen.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/organisms/user/my_page_section.dart';
import 'package:we/presentation/screens/user/my_product_management_screen.dart';
import 'package:we/presentation/screens/points/point_management_screen.dart';
import 'package:we/presentation/screens/user/purchase_history_screen.dart';
import 'package:we/presentation/molecules/modal/logout_modal.dart';
import 'package:we/presentation/screens/user/user_info_edit_screen.dart';
import 'package:we/presentation/screens/user/user_view_model.dart';

class MyPageScreen extends StatefulWidget {
  static const routeName = '/mypage';

  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserViewModel>().getMe();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<MyPageMenuItemData> menuItems = [
      MyPageMenuItemData(
        icon: Icons.monetization_on_outlined,
        title: '내 포인트 관리',
        onTap: () =>
            Navigator.of(context).pushNamed(PointManagementScreen.routeName),
      ),
      MyPageMenuItemData(
        icon: Icons.shopping_bag_outlined,
        title: '구매 내역',
        onTap: () =>
            Navigator.of(context).pushNamed(PurchaseHistoryScreen.routeName),
      ),
      MyPageMenuItemData(
        icon:
            Icons.category_outlined, // Appropriate icon for product management
        title: '내 제품 관리',
        onTap: () => Navigator.of(
          context,
        ).pushNamed(MyProductManagementScreen.routeName),
      ),
      MyPageMenuItemData(
        icon: Icons.person_outline,
        title: '내 정보 수정',
        onTap: () =>
            Navigator.of(context).pushNamed(UserInfoEditScreen.routeName),
      ),
      MyPageMenuItemData(
        icon: Icons.logout,
        title: '로그아웃',
        onTap: () async {
          showLogoutModal(
            context: context,
            onLogout: () async {
              // 먼저 모달을 닫음
              Navigator.of(context).pop();

              // 토큰 제거
              final logoutUseCase = context.read<LogoutUseCase>();
              final result = await logoutUseCase();

              // View model 상태 초기화
              if (context.mounted) {
                context.read<UserViewModel>().reset();
              }

              result.when(
                success: (_) {
                  // 토큰이 완전히 제거된 후 로그인 화면으로 이동
                  if (context.mounted) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginScreen.routeName,
                      (route) => false,
                    );
                  }
                },
                failure: (failure) {
                  ToastService.showError(failure.message);
                },
              );
            },
          );
        },
      ),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.layoutPadding),
        child: Consumer<UserViewModel>(
          builder: (context, userVM, child) {
            if (userVM.isLoading && userVM.myInfo == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (userVM.errorMessage != null) {
              return Center(
                child: Text(
                  userVM.errorMessage!,
                  style: AppTextStyles.bodyRegular.copyWith(
                    color: AppColors.error,
                  ),
                ),
              );
            }

            final myInfo = userVM.myInfo;
            if (myInfo == null) {
              return Center(
                child: Text(
                  '사용자 정보를 불러올 수 없습니다.',
                  style: AppTextStyles.bodyRegular.copyWith(
                    color: AppColors.textDisabled,
                  ),
                ),
              );
            }

            return MyPageSection(
              name: myInfo.name,
              membershipLevel: MembershipConvert.convertLevel(myInfo.level),
              points: '${myInfo.points} P',
              recommendationCount: '${myInfo.totalReferrals}명',
              menuItems: menuItems,
            );
          },
        ),
      ),
    );
  }
}
