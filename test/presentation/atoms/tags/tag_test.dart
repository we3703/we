import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:we/presentation/atoms/tags/tag.dart';
import 'package:we/presentation/foundations/colors.dart';

void main() {
  group('CustomTag', () {
    testWidgets('renders label correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: CustomTag(label: 'Test Tag')),
        ),
      );

      expect(find.text('Test Tag'), findsOneWidget);
    });

    testWidgets('shows cancel icon when onCancel is provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTag(label: 'Cancellable', onCancel: () {}),
          ),
        ),
      );

      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('does not show cancel icon when onCancel is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: CustomTag(label: 'Not Cancellable')),
        ),
      );

      expect(find.byIcon(Icons.close), findsNothing);
    });

    testWidgets('calls onPressed when tag is tapped', (
      WidgetTester tester,
    ) async {
      bool pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTag(
              label: 'Pressable',
              onPressed: () {
                pressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Pressable'));
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('calls onCancel when close icon is tapped', (
      WidgetTester tester,
    ) async {
      bool cancelled = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTag(
              label: 'Cancellable',
              onCancel: () {
                cancelled = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.close));
      await tester.pump();

      expect(cancelled, isTrue);
    });

    testWidgets('has correct background color', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: CustomTag(label: 'Styled Tag')),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(CustomTag),
          matching: find.byType(Container),
        ),
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, AppColors.tag);
    });
  });
}
