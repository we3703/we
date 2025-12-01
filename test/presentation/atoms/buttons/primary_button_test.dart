import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:we/presentation/atoms/buttons/primary_button.dart';

void main() {
  group('PrimaryButton', () {
    testWidgets('renders with provided text', (WidgetTester tester) async {
      const buttonText = 'Test Button';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(text: buttonText, onPressed: () {}),
          ),
        ),
      );

      expect(find.text(buttonText), findsOneWidget);
    });

    testWidgets('calls onPressed callback when tapped', (
      WidgetTester tester,
    ) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              text: 'Tap Me',
              onPressed: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap Me'));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('shows CircularProgressIndicator when isLoading is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              text: 'Loading',
              onPressed: () {},
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(
        find.text('Loading'),
        findsNothing,
      ); // Text should not be visible when loading
    });

    testWidgets('is disabled when isLoading is true', (
      WidgetTester tester,
    ) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              text: 'Loading Button',
              onPressed: () {
                tapped = true;
              },
              isLoading: true,
            ),
          ),
        ),
      );

      // Attempt to tap the button
      await tester.tap(find.byType(PrimaryButton));
      await tester.pump();

      expect(tapped, isFalse); // Callback should not have been called
      // Verify that the ElevatedButton itself is disabled (onPressed is null)
      final ElevatedButton button = tester.widget(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });
  });
}
