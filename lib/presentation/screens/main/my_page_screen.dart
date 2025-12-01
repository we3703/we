import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/organisms/user/my_page_section.dart';
import 'package:we/presentation/screens/auth/login_screen.dart';
import 'package:we/presentation/screens/user/my_product_management_screen.dart';
import 'package:we/presentation/screens/user/point_management_screen.dart';
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
        onTap: () {
          showLogoutModal(
            context: context,
            onLogout: () {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
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
              return Center(child: Text(userVM.errorMessage!));
            }

            final myInfo = userVM.myInfo;
            if (myInfo == null) {
              return const Center(child: Text('사용자 정보를 불러올 수 없습니다.'));
            }

            // Convert level string to membership title
            String membershipTitle;
            switch (myInfo.level.toLowerCase()) {
              case 'master':
                membershipTitle = 'Master Member';
                break;
              case 'diamond':
                membershipTitle = 'Diamond Member';
                break;
              case 'gold':
                membershipTitle = 'Gold Member';
                break;
              case 'silver':
                membershipTitle = 'Silver Member';
                break;
              default:
                membershipTitle = 'Bronze Member';
            }

            return MyPageSection(
              userName: myInfo.name,
              membershipTitle: membershipTitle,
              joinDate: '가입 날짜 ${myInfo.createdAt}',
              profileImageUrl: null, // No image in design
              menuItems: menuItems,
            );
          },
        ),
      ),
    );
  }
}
