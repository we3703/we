import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:we/presentation/molecules/appbar/search_header.dart';

void main() {
  testWidgets('SearchHeader shows hint text', (WidgetTester tester) async {
    const String hintText = 'Search here...';
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(appBar: SearchHeader(hintText: hintText)),
      ),
    );

    expect(find.text(hintText), findsOneWidget);
  });

  testWidgets('SearchHeader shows search icon', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(appBar: SearchHeader())),
    );

    expect(find.byIcon(Icons.search), findsOneWidget);
  });

  testWidgets('SearchHeader calls onSubmitted when text is submitted', (
    WidgetTester tester,
  ) async {
    String? submittedText;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: SearchHeader(
            onSubmitted: (text) {
              submittedText = text;
            },
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'test search');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    expect(submittedText, 'test search');
  });

  testWidgets('SearchHeader calls onSearchTap when tapped', (
    WidgetTester tester,
  ) async {
    bool wasTapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: SearchHeader(
            onSearchTap: () {
              wasTapped = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byType(GestureDetector));
    await tester.pump();

    expect(wasTapped, isTrue);
  });

  testWidgets('SearchHeader shows actions', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: SearchHeader(
            actions: [
              IconButton(icon: const Icon(Icons.mic), onPressed: () {}),
            ],
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.mic), findsOneWidget);
  });
}
