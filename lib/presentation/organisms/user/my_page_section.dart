import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/molecules/cards/user/user_menu_list.dart';
import 'package:we/presentation/molecules/cards/user/profile_card.dart'; // Renamed to ProfileSummaryCard

// Data model for a menu list item
class MyPageMenuItemData {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  MyPageMenuItemData({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}

class MyPageSection extends StatelessWidget {
  final String name;
  final String membershipTitle;
  final String? profileImageUrl;
  final String? joinDate;
  final List<MyPageMenuItemData> menuItems;

  const MyPageSection({
    super.key,
    required this.name,
    required this.membershipTitle,
    this.profileImageUrl,
    this.joinDate,
    required this.menuItems,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: ProfileCard(
            name: name,
            membershipTitle: membershipTitle,
            profileImageUrl: profileImageUrl,
            joinDate: joinDate,
          ),
        ),
        const SizedBox(
          height: AppSpacing.space20,
        ), // Spacing between card and menu
        UserMenuListCard(
          items: menuItems
              .map(
                (item) => MenuListItem(
                  icon: item.icon,
                  title: item.title,
                  onTap: item.onTap,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
