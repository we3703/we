import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:we/presentation/molecules/cards/product/product_detail_card.dart';

void main() {
  testWidgets("카드 디테일 확인하기", (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 1920);
    addTearDown(tester.view.resetPhysicalSize);

    const String category = "카테고리";
    const String title = "제품 제목";
    const String price = "₩1,200";
    const String remaining = "50";
    DetailSection sections = DetailSection(
      title: "섹션 제목",
      items: ["item1", "item2"],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProductDetailCard(
            title: title,
            price: price,
            category: category,
            remaining: remaining,
            sections: [sections],
          ),
        ),
      ),
    );

    expect(find.text(category), findsOneWidget);
    expect(find.text(title), findsOneWidget);
    expect(find.text(price), findsOneWidget);
    expect(find.text(remaining), findsOneWidget);
  });
}
