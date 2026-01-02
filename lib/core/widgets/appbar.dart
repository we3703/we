import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:we/core/config/constant.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final bool showNotification;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onBackTap;

  const CustomAppBar({
    super.key,
    this.title,
    this.showBackButton = false,
    this.showNotification = true,
    this.onNotificationTap,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 0,
      leadingWidth: 56,
      centerTitle: false,
      leading: showBackButton
          ? IconButton(
              icon: SvgPicture.asset(
                AppConstant.backIcon,
                width: 32,
                height: 32,
              ),
              onPressed: onBackTap ?? () => Navigator.pop(context),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Center(
                child: SvgPicture.asset(
                  AppConstant.logoPath,
                  width: 32,
                  height: 32,
                  fit: BoxFit.contain,
                ),
              ),
            ),
      title: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: title != null
            ? Text(
                title!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              )
            : const Text(
                '헬스온',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
      actions: [
        if (showNotification)
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.black,
              ),
              onPressed: onNotificationTap,
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
