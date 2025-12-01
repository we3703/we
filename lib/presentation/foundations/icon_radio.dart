import 'package:flutter/cupertino.dart';
import 'package:we/presentation/foundations/colors.dart';

class AppIconSize {
  static const double size32 = 32.0;
  static const double size24 = 24.0;
  static const double size20 = 20.0;
  static const double size40 = 40.0; // Added
}

class AppIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color? color;

  const AppIcon({
    super.key,
    required this.icon,
    required this.size,
    this.color,
  });

  const AppIcon.size32({super.key, required this.icon, this.color})
    : size = AppIconSize.size32;

  const AppIcon.size24({super.key, required this.icon, this.color})
    : size = AppIconSize.size24;

  const AppIcon.size20({super.key, required this.icon, this.color})
    : size = AppIconSize.size20;

  const AppIcon.size40({
    // Added
    super.key,
    required this.icon,
    this.color,
  }) : size = AppIconSize.size40;

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: size, color: color ?? AppColors.textPrimary);
  }
}
