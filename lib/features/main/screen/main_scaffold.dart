import 'package:flutter/material.dart';
import 'package:we/core/theme/spacing.dart';
import 'package:we/core/widgets/appbar.dart';
import 'package:we/core/widgets/bottom_bar.dart';
import 'package:we/core/widgets/input/search_input.dart';
import 'package:we/features/main/screen/home_screen.dart';
import 'package:we/presentation/screens/main/product_list_screen.dart';
import 'package:we/presentation/screens/main/recommendation_screen.dart';
import 'package:we/presentation/screens/main/my_page_screen.dart';
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
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex ?? 0;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        onNotificationTap: () {
          Navigator.of(context).pushNamed(NoticeListScreen.routeName);
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.layoutPadding),
            child: SearchInput(
              controller: _searchController,
              placeholder: '검색할 제품을 입력하세요.',
              onSubmitted: (value) {
                // TODO: 검색 로직 구현
                // 서버에서 구현이 필요함.
              },
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: IndexedStack(index: _currentIndex, children: _pages),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
