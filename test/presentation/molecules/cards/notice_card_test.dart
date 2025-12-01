import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:we/presentation/molecules/cards/notice/notice_card.dart';

void main() {
  testWidgets('NoticeCard shows title, date, and description', (
    WidgetTester tester,
  ) async {
    const String title = 'Important Announcement';
    const String date = '2025-11-24';
    const String description =
        'This is a very important notice regarding the upcoming event. Please read carefully.';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: NoticeCard(title: title, date: date, description: description),
        ),
      ),
    );

    expect(find.text(title), findsOneWidget);
    expect(find.text(date), findsOneWidget);
    expect(find.text(description), findsOneWidget);
  });

  testWidgets('NoticeCard onTap callback is called', (
    WidgetTester tester,
  ) async {
    bool wasTapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NoticeCard(
            title: 'Title',
            date: 'Date',
            description: 'Description',
            onTap: () {
              wasTapped = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byType(InkWell));
    await tester.pump();

    expect(wasTapped, isTrue);
  });
}
