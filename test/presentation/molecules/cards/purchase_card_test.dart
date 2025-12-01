import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:we/presentation/atoms/buttons/primary_button.dart';
import 'package:we/presentation/foundations/image_radio.dart';
import 'package:we/presentation/molecules/cards/purchase/purchase_card.dart';

void main() {
  // A mock for AppImage to avoid network errors in tests
  // This can be a simple container or a placeholder image.
  // For this test, we just check its existence.

  testWidgets('ProductCard shows all details and handles repurchase', (
    WidgetTester tester,
  ) async {
    // Set a larger screen size to prevent overflow
    tester.view.physicalSize = const Size(1080, 1920);
    addTearDown(tester.view.resetPhysicalSize);

    bool repurchasePressed = false;
    const String imageUrl = 'https://picsum.photos/200/300';
    const String productName = 'Awesome Gadget';
    const int price = 1200000;
    const String purchaseDate = '2025.10.25';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PurchaseCard(
            imageUrl: imageUrl,
            productName: productName,
            price: price,
            purchaseDate: purchaseDate,
            onRepurchasePressed: () {
              repurchasePressed = true;
            },
          ),
        ),
      ),
    );

    // Verify all text fields are displayed
    expect(find.text(productName), findsOneWidget);
    expect(find.text('$price P'), findsOneWidget);
    expect(find.text('구매일 $purchaseDate'), findsOneWidget);

    // Verify the image widget is present
    expect(find.byType(AppImage), findsOneWidget);

    // Verify the repurchase button is present and tappable
    final repurchaseButton = find.widgetWithText(PrimaryButton, '재구매');
    expect(repurchaseButton, findsOneWidget);
    await tester.tap(repurchaseButton);
    await tester.pump();
    expect(repurchasePressed, isTrue);
  });

  testWidgets('ProductCard shows correctly without optional fields', (
    WidgetTester tester,
  ) async {
    // Set a larger screen size to prevent overflow
    tester.view.physicalSize = const Size(1080, 1920);
    addTearDown(tester.view.resetPhysicalSize);

    const String imageUrl = 'https://picsum.photos/200/300';
    const String productName = 'Simple Item';
    const int price = 50000;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PurchaseCard(
            imageUrl: imageUrl,
            productName: productName,
            price: price,
            // No description, purchaseDate, or onRepurchasePressed
          ),
        ),
      ),
    );

    // Verify required fields are displayed
    expect(find.text(productName), findsOneWidget);
    expect(find.text('$price P'), findsOneWidget);
    expect(find.byType(AppImage), findsOneWidget);

    // Verify optional fields are not displayed
    // The description is an empty string by default, so it won't be in the tree.
    expect(find.text('구매일 '), findsNothing);
    expect(find.byType(PrimaryButton), findsNothing);
  });
}
