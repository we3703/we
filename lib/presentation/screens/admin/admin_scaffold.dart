import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/molecules/appbar/app_header.dart';
import 'package:we/presentation/molecules/navigation/bottom_nav_bar.dart';
import 'package:we/presentation/screens/admin/notice/admin_notice_screen.dart';
import 'package:we/presentation/screens/admin/order/admin_order_screen.dart';
import 'package:we/presentation/screens/admin/product/admin_product_screen.dart';
import 'package:we/presentation/screens/admin/referral/admin_referral_screen.dart';
import 'package:we/presentation/screens/admin/user/admin_user_screen.dart';

class AdminScaffold extends StatefulWidget {
  static const routeName = '/admin';
  final int? initialIndex;

  const AdminScaffold({super.key, this.initialIndex});

  @override
  State<AdminScaffold> createState() => _AdminScaffoldState();
}

class _AdminScaffoldState extends State<AdminScaffold> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex ?? 0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Handle arguments from navigation
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is int) {
      setState(() {
        _currentIndex = args;
      });
    }
  }

  final List<Widget> _pages = const [
    AdminProductScreen(),
    AdminOrderScreen(),
    AdminReferralScreen(),
    AdminUserScreen(),
    AdminNoticeScreen(),
  ];

  final List<BottomNavItemData> _navItems = const [
    BottomNavItemData(icon: Icons.inventory_outlined, label: '제품'),
    BottomNavItemData(icon: Icons.shopping_bag_outlined, label: '주문'),
    BottomNavItemData(icon: Icons.groups_outlined, label: '추천'),
    BottomNavItemData(icon: Icons.people_outline, label: '사용자'),
    BottomNavItemData(icon: Icons.announcement_outlined, label: '공지'),
  ];

  PreferredSizeWidget _buildAppBar() {
    return AppHeader(
      titleWidget: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/Logo.png', height: 24),
          const SizedBox(width: AppSpacing.space8),
          Text(
            '헬스온 관리자',
            style: AppTextStyles.heading3Bold.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _navItems,
      ),
    );
  }
}
