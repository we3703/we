import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:we/presentation/atoms/inputs/text_input.dart';

void main() {
  group('TextInput', () {
    testWidgets('renders label and hint text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextInput(
              labelText: 'Username',
              hintText: 'Enter your username',
              onChanged: (_) {},
            ),
          ),
        ),
      );

      // Use a predicate to find the RichText for the label, as find.text() can miss it.
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is RichText &&
              widget.text.toPlainText().startsWith('Username'),
        ),
        findsOneWidget,
      );
      // The hintText is rendered by the TextFormField's decoration, so find.text() works here.
      expect(find.text('Enter your username'), findsOneWidget);
    });

    testWidgets('shows required indicator when isRequired is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextInput(
              labelText: 'Password',
              isRequired: true,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      final richText = tester.widget<RichText>(find.byType(RichText));
      final textSpan = richText.text as TextSpan;
      expect(textSpan.children, isNotNull);
      expect(textSpan.children!.length, 1);
      final requiredSpan = textSpan.children![0] as TextSpan;
      expect(requiredSpan.text, ' *');
    });

    testWidgets('calls onChanged with entered text', (
      WidgetTester tester,
    ) async {
      String? changedValue;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextInput(
              labelText: 'Email',
              onChanged: (value) {
                changedValue = value;
              },
            ),
          ),
        ),
      );

      const testInput = 'test@example.com';
      await tester.enterText(find.byType(TextFormField), testInput);
      await tester.pump();

      expect(changedValue, testInput);
    });

    testWidgets('obscures text when obscureText is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextInput(
              labelText: 'Password',
              obscureText: true,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      final editableText = tester.widget<EditableText>(
        find.byType(EditableText),
      );
      expect(editableText.obscureText, isTrue);
    });

    testWidgets('displays error message when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextInput(
              labelText: 'Confirm Password',
              errorMessage: 'Passwords do not match',
              onChanged: (_) {},
            ),
          ),
        ),
      );

      await tester.pump(); // Allow for the error text to be built
      expect(find.text('Passwords do not match'), findsOneWidget);
    });
  });
}
