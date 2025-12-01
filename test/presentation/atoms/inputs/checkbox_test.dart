import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:we/presentation/atoms/inputs/checkbox.dart';
import 'package:we/presentation/foundations/colors.dart';

void main() {
  group('CustomCheckbox', () {
    testWidgets('renders label correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCheckbox(
              label: 'Accept Terms',
              value: false,
              onChanged: (_) {},
            ),
          ),
        ),
      );
      expect(find.text('Accept Terms'), findsOneWidget);
    });

    testWidgets('shows correct initial value (unchecked)', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCheckbox(
              label: 'Unchecked',
              value: false,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.value, isFalse);
    });

    testWidgets('shows correct initial value (checked)', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCheckbox(
              label: 'Checked',
              value: true,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.value, isTrue);
    });

    testWidgets('calls onChanged with new value when checkbox is tapped', (
      WidgetTester tester,
    ) async {
      bool? aNewvalue;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCheckbox(
              label: 'Tap Checkbox',
              value: false,
              onChanged: (value) {
                aNewvalue = value;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      expect(aNewvalue, isTrue);
    });

    testWidgets('calls onChanged with new value when label is tapped', (
      WidgetTester tester,
    ) async {
      bool? aNewvalue;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCheckbox(
              label: 'Tap Label',
              value: false,
              onChanged: (value) {
                aNewvalue = value;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap Label'));
      await tester.pump();

      // Note: The parent InkWell calls onChanged(!value), so it should be true.
      expect(aNewvalue, isTrue);
    });

    testWidgets('shows disabled style when onChanged is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomCheckbox(
              label: 'Disabled',
              value: false,
              onChanged: null,
            ),
          ),
        ),
      );

      final text = tester.widget<Text>(find.text('Disabled'));
      expect(text.style?.color, AppColors.textDisabled);

      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.onChanged, isNull);
    });
  });
}
