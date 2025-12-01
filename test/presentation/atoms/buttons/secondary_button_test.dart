import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:we/presentation/atoms/buttons/secondary_button.dart';

void main() {
  group("secondary_button_test", () {
    testWidgets("렌더링 테스트", (WidgetTester tester) async {
      const buttonText = "Secondary";
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SecondaryButton(text: buttonText, onPressed: () {}),
          ),
        ),
      );

      expect(find.text(buttonText), findsOneWidget);
    });

    testWidgets("클릭 시 함수 호출", (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SecondaryButton(
              text: "Tap Me",
              onPressed: () {
                tapped = true;
              },
            ),
          ),
        ),
      );
      await tester.tap(find.text("Tap Me"));
      await tester.pump();

      expect(tapped, isTrue);
    });
  });
}
