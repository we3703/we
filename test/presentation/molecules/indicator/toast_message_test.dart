import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/molecules/indicator/toast_message.dart';

void main() {
  testWidgets('ToastMessage displays the correct message and styling', (
    WidgetTester tester,
  ) async {
    const String message = 'This is a toast message.';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: ToastMessage(message: message)),
      ),
    );

    // Verify the message is displayed
    expect(find.text(message), findsOneWidget);

    // Verify the container's decoration
    final container = tester.widget<Container>(find.byType(Container));
    final decoration = container.decoration as BoxDecoration;

    expect(decoration.color, AppColors.toast);
    expect(decoration.borderRadius, BorderRadius.circular(8.0));

    // Verify the text style
    final text = tester.widget<Text>(find.text(message));
    expect(text.style?.color, AppColors.surface);
  });
}
