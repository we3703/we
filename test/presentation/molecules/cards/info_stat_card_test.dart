import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:we/presentation/molecules/cards/user/info_stat_card.dart';

void main() {
  testWidgets('InfoStatCard shows title and stats', (
    WidgetTester tester,
  ) async {
    const String title = 'User Stats';
    final List<InfoStatItem> stats = [
      InfoStatItem(title: 'Followers', value: '1,234'),
      InfoStatItem(title: 'Following', value: '567'),
      InfoStatItem(title: 'Posts', value: '890'),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InfoStatCard(title: title, stats: stats),
        ),
      ),
    );

    // Verify title is displayed
    expect(find.text(title), findsOneWidget);

    // Verify each stat item is displayed
    for (final stat in stats) {
      expect(find.text(stat.title), findsOneWidget);
      expect(find.text(stat.value), findsOneWidget);
    }
  });

  testWidgets('InfoStatCard displays correct number of stats', (
    WidgetTester tester,
  ) async {
    final List<InfoStatItem> stats = [
      InfoStatItem(title: 'Likes', value: '10K'),
      InfoStatItem(title: 'Comments', value: '500'),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InfoStatCard(title: 'Post Stats', stats: stats),
        ),
      ),
    );

    // The number of columns should match the number of stats
    final columnFind = find.byType(Column);
    // There's one outer Column, and one for each stat item.
    expect(columnFind, findsNWidgets(1 + stats.length));
  });
}
