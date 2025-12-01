import 'package:flutter/material.dart';
import 'package:we/presentation/molecules/tab/quick_action_button.dart';

class QuickActionGroup extends StatelessWidget {
  final List<QuickActionButton> actions;

  const QuickActionGroup({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: actions,
    );
  }
}
