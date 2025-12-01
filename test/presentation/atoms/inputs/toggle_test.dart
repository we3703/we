import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:we/presentation/atoms/inputs/toggle.dart';

void main() {
  group('CustomToggle', () {
    testWidgets('renders with correct initial value (false)', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: CustomToggle(value: false, onChanged: (_) {})),
        ),
      );

      final toggle = tester.widget<Switch>(find.byType(Switch));
      expect(toggle.value, isFalse);
    });

    testWidgets('renders with correct initial value (true)', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: CustomToggle(value: true, onChanged: (_) {})),
        ),
      );

      final toggle = tester.widget<Switch>(find.byType(Switch));
      expect(toggle.value, isTrue);
    });

    testWidgets('calls onChanged with new value when tapped', (
      WidgetTester tester,
    ) async {
      bool? aNewvalue;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomToggle(
              value: false,
              onChanged: (value) {
                aNewvalue = value;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Switch));
      await tester.pump();

      expect(aNewvalue, isTrue);
    });

    testWidgets('is disabled when onChanged is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: CustomToggle(value: false, onChanged: null)),
        ),
      );

      final toggle = tester.widget<Switch>(find.byType(Switch));
      expect(toggle.onChanged, isNull);
    });
  });
}
