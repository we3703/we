import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:we/presentation/atoms/buttons/link_button.dart';
import 'package:we/presentation/foundations/image_radio.dart';
import 'package:we/presentation/molecules/cards/product/product_card.dart';

void main() {
  testWidgets('ProductMiniCard displays product details and link button', (
    WidgetTester tester,
  ) async {
    bool detailsPressed = false;
    const String imageUrl = 'https://picsum.photos/id/100/80/80';
    const String productName = 'Mini Product';
    const String description = 'A small description for the mini product.';
    const String price = '₩10,000';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProductCard(
            imageUrl: imageUrl,
            productName: productName,
            productDescription: description,
            price: price,
            onDetailsPressed: () {
              detailsPressed = true;
            },
            showQuantityRemaining: false, // Ensure LinkButton is shown
          ),
        ),
      ),
    );

    expect(find.text(productName), findsOneWidget);
    expect(find.text(description), findsOneWidget);
    expect(find.text(price), findsOneWidget);
    expect(find.byType(AppImage), findsOneWidget);
    expect(find.byType(LinkButton), findsOneWidget);
    expect(find.text('상세보기'), findsOneWidget);

    await tester.tap(find.byType(LinkButton));
    await tester.pump();
    expect(detailsPressed, isTrue);
    expect(
      find.textContaining('개 남음'),
      findsNothing,
    ); // Ensure quantity remaining is not shown
  });

  testWidgets(
    'ProductMiniCard displays quantity remaining when showQuantityRemaining is true',
    (WidgetTester tester) async {
      const String imageUrl = 'https://picsum.photos/id/101/80/80';
      const String productName = 'Limited Stock Product';
      const String description = 'This product has limited stock.';
      const String price = '₩20,000';
      const String quantity = '5개 남음';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCard(
              imageUrl: imageUrl,
              productName: productName,
              productDescription: description,
              price: price,
              quantityRemaining: quantity,
              showQuantityRemaining: true, // Ensure quantity remaining is shown
              onDetailsPressed:
                  () {}, // Even if present, quantity takes precedence
            ),
          ),
        ),
      );

      expect(find.text(productName), findsOneWidget);
      expect(find.text(description), findsOneWidget);
      expect(find.text(price), findsOneWidget);
      expect(find.byType(AppImage), findsOneWidget);
      expect(find.text(quantity), findsOneWidget);
      expect(
        find.byType(LinkButton),
        findsNothing,
      ); // LinkButton should not be shown
    },
  );

  testWidgets('ProductMiniCard handles missing optional fields gracefully', (
    WidgetTester tester,
  ) async {
    const String imageUrl = 'https://picsum.photos/id/102/80/80';
    const String productName = 'Product without options';
    const String description = 'No extra info.';
    const String price = '₩5,000';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProductCard(
            imageUrl: imageUrl,
            productName: productName,
            productDescription: description,
            price: price,
            // No onDetailsPressed, quantityRemaining, showQuantityRemaining
          ),
        ),
      ),
    );

    expect(find.text(productName), findsOneWidget);
    expect(find.text(description), findsOneWidget);
    expect(find.text(price), findsOneWidget);
    expect(find.byType(AppImage), findsOneWidget);
    expect(find.byType(LinkButton), findsNothing);
    expect(find.textContaining('개 남음'), findsNothing);
  });
}
