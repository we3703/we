import 'package:flutter/material.dart';
import 'package:we/presentation/molecules/appbar/app_header.dart';

class MyProductManagementScreen extends StatelessWidget {
  static const String routeName = '/myProductManagement';

  const MyProductManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppHeader(title: '내 제품 관리', showBackButton: true),
      body: Center(child: Text('내 제품 관리 화면')),
    );
  }
}
