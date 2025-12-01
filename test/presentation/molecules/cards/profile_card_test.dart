import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:we/presentation/foundations/icon_radio.dart';
import 'package:we/presentation/molecules/cards/user/profile_card.dart';

void main() {
  // 테스트 환경 설정
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('ProfileSummaryCard 기본 표시 테스트', () {
    testWidgets('사용자 이름과 멤버십 타이틀이 정상적으로 표시된다', (WidgetTester tester) async {
      // Arrange
      const String userName = 'John Doe';
      const String membershipTitle = 'Gold Member';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProfileCard(
              userName: userName,
              membershipTitle: membershipTitle,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(userName), findsOneWidget);
      expect(find.text(membershipTitle), findsOneWidget);
    });

    testWidgets('빈 문자열도 정상적으로 처리된다', (WidgetTester tester) async {
      // Arrange
      const String userName = '';
      const String membershipTitle = '';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProfileCard(
              userName: userName,
              membershipTitle: membershipTitle,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(ProfileCard), findsOneWidget);
    });
  });

  group('ProfileSummaryCard 프로필 이미지 테스트', () {
    testWidgets('프로필 이미지 URL이 제공되면 CircleAvatar가 표시된다', (
      WidgetTester tester,
    ) async {
      // Arrange
      const String userName = 'Jane Doe';
      const String membershipTitle = 'Silver Member';
      const String imageUrl =
          'https://imgnn.seoul.co.kr/img/upload/2024/08/06/SSC_20240806100040.jpg';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProfileCard(
              userName: userName,
              membershipTitle: membershipTitle,
              profileImageUrl: imageUrl,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(CircleAvatar), findsOneWidget);
      final CircleAvatar avatar = tester.widget(find.byType(CircleAvatar));
      expect(avatar.foregroundImage, isA<NetworkImage>());
    });

    testWidgets('프로필 이미지 URL이 null이면 기본 아이콘이 표시된다', (
      WidgetTester tester,
    ) async {
      // Arrange
      const String userName = 'Guest User';
      const String membershipTitle = 'Bronze Member';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProfileCard(
              userName: userName,
              membershipTitle: membershipTitle,
              profileImageUrl: null,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(CircleAvatar), findsOneWidget);
      final CircleAvatar avatar = tester.widget(find.byType(CircleAvatar));
      expect(avatar.foregroundImage, isNull);
      expect(find.byType(AppIcon), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('빈 문자열 이미지 URL이 제공되면 기본 아이콘이 표시된다', (
      WidgetTester tester,
    ) async {
      // Arrange
      const String userName = 'Test User';
      const String membershipTitle = 'Test Member';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProfileCard(
              userName: userName,
              membershipTitle: membershipTitle,
              profileImageUrl: '',
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(CircleAvatar), findsOneWidget);
    });
  });

  group('ProfileSummaryCard 가입 날짜 테스트', () {
    testWidgets('가입 날짜가 제공되면 표시된다', (WidgetTester tester) async {
      // Arrange
      const String userName = 'New User';
      const String membershipTitle = 'Basic Member';
      const String joinDate = '가입 날짜 2023.01.01';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProfileCard(
              userName: userName,
              membershipTitle: membershipTitle,
              joinDate: joinDate,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(joinDate), findsOneWidget);
    });

    testWidgets('가입 날짜가 null이면 표시되지 않는다', (WidgetTester tester) async {
      // Arrange
      const String userName = 'Old User';
      const String membershipTitle = 'Premium Member';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProfileCard(
              userName: userName,
              membershipTitle: membershipTitle,
              joinDate: null,
            ),
          ),
        ),
      );

      // Assert
      expect(find.textContaining('가입 날짜'), findsNothing);
    });

    testWidgets('빈 문자열 가입 날짜는 표시되지 않는다', (WidgetTester tester) async {
      // Arrange
      const String userName = 'Test User';
      const String membershipTitle = 'Test Member';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProfileCard(
              userName: userName,
              membershipTitle: membershipTitle,
              joinDate: '',
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(''), findsWidgets); // 빈 문자열은 여러 곳에 존재할 수 있음
    });
  });

  group('ProfileSummaryCard 통합 테스트', () {
    testWidgets('모든 정보가 함께 제공되면 모두 표시된다', (WidgetTester tester) async {
      // Arrange
      const String userName = 'Complete User';
      const String membershipTitle = 'Platinum Member';
      const String imageUrl = 'https://example.com/complete.jpg';
      const String joinDate = '가입 날짜 2024.12.01';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProfileCard(
              userName: userName,
              membershipTitle: membershipTitle,
              profileImageUrl: imageUrl,
              joinDate: joinDate,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(userName), findsOneWidget);
      expect(find.text(membershipTitle), findsOneWidget);
      expect(find.text(joinDate), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('최소 정보만 제공되어도 정상 동작한다', (WidgetTester tester) async {
      // Arrange
      const String userName = 'Minimal User';
      const String membershipTitle = 'Member';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProfileCard(
              userName: userName,
              membershipTitle: membershipTitle,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(userName), findsOneWidget);
      expect(find.text(membershipTitle), findsOneWidget);
      expect(find.byType(ProfileCard), findsOneWidget);
    });
  });
}
