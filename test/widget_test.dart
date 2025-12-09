import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:we/presentation/screens/auth/login_screen.dart';

import 'test_helper.dart';

void main() {
  testWidgets('LoginScreen shows logo', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(createTestableWidget(child: const LoginScreen()));

    // Verify that the logo is displayed.
    expect(find.byType(Image), findsOneWidget);
    final image = tester.widget<Image>(find.byType(Image));
    expect((image.image as AssetImage).assetName, 'assets/Logo.png');
  });
}
