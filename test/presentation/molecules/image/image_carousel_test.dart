import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:we/presentation/molecules/image/image_carousel.dart';
import 'package:we/presentation/molecules/image/image_carousel_item.dart';
import 'package:we/presentation/molecules/indicator/carousel_indicator.dart';

void main() {
  final imageUrls = [
    'https://picsum.photos/id/1/300/200',
    'https://picsum.photos/id/2/300/200',
    'https://picsum.photos/id/3/300/200',
  ];

  testWidgets('ImageCarousel displays correct initial state', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: ImageCarousel(imageUrls: imageUrls, height: 200)),
      ),
    );

    // Verify PageView is present and shows the first item
    expect(find.byType(PageView), findsOneWidget);
    expect(
      find.byType(ImageCarouselItem),
      findsOneWidget,
    ); // Only one is visible at a time

    // Verify CarouselIndicator is present and state is correct
    final indicator = tester.widget<CarouselIndicator>(
      find.byType(CarouselIndicator),
    );
    expect(indicator, isNotNull);
    expect(indicator.itemCount, imageUrls.length);
    expect(indicator.currentIndex, 0);
  });

  testWidgets('ImageCarousel updates indicator on page swipe', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: ImageCarousel(imageUrls: imageUrls, height: 200)),
      ),
    );

    // Initial state check
    var indicator = tester.widget<CarouselIndicator>(
      find.byType(CarouselIndicator),
    );
    expect(indicator.currentIndex, 0);

    // Swipe to the next page
    await tester.drag(find.byType(PageView), const Offset(-400.0, 0.0));
    await tester.pumpAndSettle(); // Wait for animation to finish

    // Verify indicator updated
    indicator = tester.widget<CarouselIndicator>(
      find.byType(CarouselIndicator),
    );
    expect(indicator.currentIndex, 1);

    // Swipe to the last page
    await tester.drag(find.byType(PageView), const Offset(-400.0, 0.0));
    await tester.pumpAndSettle();

    // Verify indicator updated
    indicator = tester.widget<CarouselIndicator>(
      find.byType(CarouselIndicator),
    );
    expect(indicator.currentIndex, 2);
  });
}
