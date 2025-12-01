import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:we/presentation/molecules/cards/user/user_menu_list.dart';

void main() {
  testWidgets('MenuListCard renders all items', (WidgetTester tester) async {
    int tapCount = 0;
    final items = [
      MenuListItem(
        icon: Icons.settings,
        title: 'Settings',
        onTap: () => tapCount++,
      ),
      MenuListItem(
        icon: Icons.person,
        title: 'Profile',
        onTap: () => tapCount++,
      ),
      MenuListItem(
        icon: Icons.logout,
        title: 'Logout',
        onTap: () => tapCount++,
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: UserMenuListCard(items: items)),
      ),
    );

    // Verify all items are rendered
    for (final item in items) {
      expect(find.text(item.title), findsOneWidget);
      expect(find.byIcon(item.icon), findsOneWidget);
    }

    // Verify forward arrow icons are present for each item
    expect(find.byIcon(Icons.arrow_forward_ios), findsNWidgets(items.length));
  });

  testWidgets('MenuListCard onTap callback is called', (
    WidgetTester tester,
  ) async {
    int tapIndex = -1;
    final items = [
      MenuListItem(
        icon: Icons.settings,
        title: 'Settings',
        onTap: () => tapIndex = 0,
      ),
      MenuListItem(
        icon: Icons.person,
        title: 'Profile',
        onTap: () => tapIndex = 1,
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: UserMenuListCard(items: items)),
      ),
    );

    // Tap the first item
    await tester.tap(find.text('Settings'));
    await tester.pump();
    expect(tapIndex, 0);

    // Tap the second item
    await tester.tap(find.text('Profile'));
    await tester.pump();
    expect(tapIndex, 1);
  });

  testWidgets('MenuListCard shows dividers correctly', (
    WidgetTester tester,
  ) async {
    final items = [
      MenuListItem(icon: Icons.one_k, title: 'One', onTap: () {}),
      MenuListItem(icon: Icons.two_k, title: 'Two', onTap: () {}),
      MenuListItem(icon: Icons.three_k, title: 'Three', onTap: () {}),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: UserMenuListCard(items: items)),
      ),
    );

    // There should be a divider after 'One' and 'Two', but not 'Three'.
    // So, items.length - 1 dividers should be present.
    expect(find.byType(Divider), findsNWidgets(items.length - 1));
  });

  testWidgets('MenuListCard shows no dividers for a single item', (
    WidgetTester tester,
  ) async {
    final items = [MenuListItem(icon: Icons.one_k, title: 'One', onTap: () {})];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: UserMenuListCard(items: items)),
      ),
    );

    expect(find.byType(Divider), findsNothing);
  });
}
