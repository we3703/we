import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:we/presentation/foundations/image_radio.dart';
import 'package:we/presentation/molecules/image/image_carousel_item.dart';

void main() {
  testWidgets('ImageCarouselItem displays an AppImage with correct imageUrl', (
    WidgetTester tester,
  ) async {
    const String testImageUrl = 'https://picsum.photos/id/10/300/200';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: ImageCarouselItem(imageUrl: testImageUrl)),
      ),
    );

    // Find the AppImage widget
    final appImageFinder = find.byType(AppImage);
    expect(appImageFinder, findsOneWidget);

    // Verify its properties
    final appImageWidget = tester.widget<AppImage>(appImageFinder);
    expect(appImageWidget.imageUrl, testImageUrl);
    expect(appImageWidget.ratioType, ImageRatioType.ratio3x2);
    expect(appImageWidget.fit, BoxFit.cover);
  });
}
