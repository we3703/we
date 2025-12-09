import 'package:flutter/material.dart';
import 'package:we/presentation/molecules/appbar/app_header.dart';
import 'package:we/presentation/organisms/referral/referral_tree_widget.dart';

class ReferralTreeScreen extends StatelessWidget {
  static const routeName = '/referralTree';

  const ReferralTreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: '추천 트리', showBackButton: true),
      body: const ReferralTreeWidget(),
    );
  }
}
