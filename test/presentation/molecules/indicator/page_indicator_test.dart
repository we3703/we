import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:we/presentation/molecules/indicator/page_indicator.dart';

void main() {
  int currentPage = 1;

  void onPageChanged(int newPage) {
    currentPage = newPage;
  }

  setUp(() {
    currentPage = 1;
  });

  testWidgets('PageIndicator renders correctly and handles taps', (
    WidgetTester tester,
  ) async {
    const totalPages = 5;

    // Use a stateful wrapper to test state changes
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return PageIndicator(
                currentPage: currentPage,
                totalPages: totalPages,
                onPageChanged: (newPage) {
                  setState(() {
                    onPageChanged(newPage);
                  });
                },
              );
            },
          ),
        ),
      ),
    );

    // Verify correct numbers are displayed
    for (int i = 1; i <= totalPages; i++) {
      expect(find.text('$i'), findsOneWidget);
    }

    // Verify page 1 is initially active (bold)
    var currentPageText = tester.widget<Text>(find.text('$currentPage'));
    expect(currentPageText.style?.fontWeight, FontWeight.bold);
    var otherPageText = tester.widget<Text>(find.text('2'));
    expect(otherPageText.style?.fontWeight, isNot(FontWeight.bold));

    // Tap on page 3
    await tester.tap(find.text('3'));
    await tester.pumpAndSettle();
    expect(currentPage, 3);

    // Verify page 3 is now active
    currentPageText = tester.widget<Text>(find.text('$currentPage'));
    expect(currentPageText.style?.fontWeight, FontWeight.bold);

    // Tap on forward button
    await tester.tap(find.byIcon(Icons.arrow_forward_ios));
    await tester.pumpAndSettle();
    expect(currentPage, 4);

    // Tap on back button
    await tester.tap(find.byIcon(Icons.arrow_back_ios));
    await tester.pumpAndSettle();
    expect(currentPage, 3);
  });

  testWidgets('PageIndicator disables buttons at boundaries', (
    WidgetTester tester,
  ) async {
    const totalPages = 3;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return PageIndicator(
                currentPage: currentPage,
                totalPages: totalPages,
                onPageChanged: (newPage) {
                  setState(() => onPageChanged(newPage));
                },
              );
            },
          ),
        ),
      ),
    );

    // At page 1, back button should be disabled
    var backButton = tester.widget<IconButton>(
      find.widgetWithIcon(IconButton, Icons.arrow_back_ios),
    );
    expect(backButton.onPressed, isNull);
    var forwardButton = tester.widget<IconButton>(
      find.widgetWithIcon(IconButton, Icons.arrow_forward_ios),
    );
    expect(forwardButton.onPressed, isNotNull);

    // Go to last page
    await tester.tap(find.text('3'));
    await tester.pumpAndSettle();
    expect(currentPage, 3);

    // At last page, forward button should be disabled
    backButton = tester.widget<IconButton>(
      find.widgetWithIcon(IconButton, Icons.arrow_back_ios),
    );
    expect(backButton.onPressed, isNotNull);
    forwardButton = tester.widget<IconButton>(
      find.widgetWithIcon(IconButton, Icons.arrow_forward_ios),
    );
    expect(forwardButton.onPressed, isNull);
  });
}
