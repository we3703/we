import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:we/core/config/constant.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/icon_radio.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/molecules/appbar/app_header.dart';
import 'package:we/presentation/molecules/navigation/bottom_nav_bar.dart';
import 'package:we/presentation/screens/main/home_screen.dart';
import 'package:we/presentation/screens/main/my_page_screen.dart';
import 'package:we/presentation/screens/main/product_list_screen.dart';
import 'package:we/presentation/screens/main/recommendation_screen.dart';
import 'package:we/presentation/screens/notice/notice_list_screen.dart';

class MainScaffold extends StatefulWidget {
  static const routeName = '/main';
  final int? initialIndex;

  const MainScaffold({super.key, this.initialIndex});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
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

  final List<Widget> _pages = [
    const HomeScreen(),
    const ProductListScreen(),
    const RecommendationScreen(),
    const MyPageScreen(),
  ];

  final List<BottomNavItemData> _navItems = const [
    BottomNavItemData(icon: Icons.home_outlined, label: '홈'),
    BottomNavItemData(icon: Icons.shopping_bag_outlined, label: '제품'),
    BottomNavItemData(icon: Icons.groups_outlined, label: '조직도'),
    BottomNavItemData(icon: Icons.person_outline, label: '마이'),
  ];

  PreferredSizeWidget _buildAppBar() {
    return AppHeader(
      titleWidget: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(AppConstant.logoPath, width: 24, height: 24),
          const SizedBox(width: AppSpacing.space8),
          Text(
            '헬스온',
            style: AppTextStyles.heading3Bold.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
      showSearchAction: true,
      searchAtStart: true,
      onSearchSubmitted: (value) {
        // TODO: Implement search logic for home
        // ignore: avoid_print
        print('Searching for: $value');
      },
      actions: [
        IconButton(
          icon: const AppIcon.size24(icon: Icons.notifications_none_outlined),
          onPressed: () {
            Navigator.of(context).pushNamed(NoticeListScreen.routeName);
          },
        ),
      ],
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
