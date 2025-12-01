import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:we/presentation/molecules/appbar/app_header.dart';

void main() {
  testWidgets('AppHeader shows title', (WidgetTester tester) async {
    const String title = 'Test Title';
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(appBar: AppHeader(title: title)),
      ),
    );

    expect(find.text(title), findsOneWidget);
  });

  testWidgets('AppHeader shows back button when showBackButton is true', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: const AppHeader(showBackButton: true),
          body: Container(),
        ),
      ),
    );

    expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
  });

  testWidgets('AppHeader does not show back button by default', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(appBar: AppHeader())),
    );

    expect(find.byIcon(Icons.arrow_back_ios), findsNothing);
  });

  testWidgets('AppHeader shows actions', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppHeader(
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none),
                onPressed: () {},
              ),
              IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            ],
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.search), findsOneWidget);
  });

  testWidgets('AppHeader shows titleWidget', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(appBar: AppHeader(title: 'Custom Title')),
      ),
    );

    expect(find.text('Custom Title'), findsOneWidget);
  });
}
