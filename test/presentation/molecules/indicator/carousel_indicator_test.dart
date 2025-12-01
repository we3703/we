import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:we/presentation/molecules/indicator/carousel_indicator.dart';

void main() {
  testWidgets('CarouselIndicator renders correct number of dots', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: CarouselIndicator(itemCount: 5, currentIndex: 0)),
      ),
    );

    // There should be 5 container widgets representing the dots
    expect(find.byType(Container), findsNWidgets(5));
  });

  testWidgets('CarouselIndicator highlights the active dot correctly', (
    WidgetTester tester,
  ) async {
    const int itemCount = 3;
    const int currentIndex = 1;
    const Color activeColor = Colors.blue;
    const Color inactiveColor = Colors.grey;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CarouselIndicator(
            itemCount: itemCount,
            currentIndex: currentIndex,
            activeColor: activeColor,
            inactiveColor: inactiveColor,
          ),
        ),
      ),
    );

    final containers = tester.widgetList<Container>(find.byType(Container));
    expect(containers.length, itemCount);

    for (int i = 0; i < containers.length; i++) {
      final decoration = containers.elementAt(i).decoration as BoxDecoration;
      if (i == currentIndex) {
        expect(decoration.color, activeColor);
      } else {
        expect(decoration.color, inactiveColor);
      }
    }
  });

  testWidgets('CarouselIndicator uses correct dot size and spacing', (
    WidgetTester tester,
  ) async {
    const double dotSize = 12.0;
    const double spacing = 10.0;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CarouselIndicator(
            itemCount: 3,
            currentIndex: 0,
            dotSize: dotSize,
            spacing: spacing,
          ),
        ),
      ),
    );

    final containers = tester.widgetList<Container>(find.byType(Container));
    for (final container in containers) {
      expect(container.constraints?.minWidth, dotSize);
      expect(container.constraints?.minHeight, dotSize);
      expect(
        container.margin,
        const EdgeInsets.symmetric(horizontal: spacing / 2),
      );
    }
  });
}
