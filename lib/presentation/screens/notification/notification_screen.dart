import 'package:flutter/material.dart';
import 'package:we/presentation/molecules/appbar/app_header.dart';

class NotificationScreen extends StatelessWidget {
  static const String routeName = '/notifications';

  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppHeader(title: '알림', showBackButton: true),
      body: Center(child: Text('알림 화면')),
    );
  }
}
