import 'package:flutter/material.dart';
import 'package:we/core/theme/spacing.dart';
import 'package:we/core/widgets/appbar.dart';
import 'package:we/core/widgets/bottom_bar.dart';
import 'package:we/core/widgets/input/search_input.dart';
import 'package:we/features/main/screen/home_screen.dart';

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
    const Center(child: Text('제품 페이지')),
    const Center(child: Text('추천도 페이지')),
    const Center(child: Text('마이 페이지')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        onNotificationTap: () {
          // TODO: 알림 페이지로 이동
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
