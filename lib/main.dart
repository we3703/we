import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:we/core/auth/token_provider.dart';
import 'package:we/core/routes/app_routes.dart';
import 'package:we/dependency_injection.dart'; // Import the new DI file
import 'package:we/presentation/foundations/app_theme.dart';
import 'package:we/presentation/screens/auth/login_screen.dart';
import 'package:we/presentation/screens/auth/signup_screen.dart';
import 'package:we/presentation/screens/main/main_scaffold.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'env');

  final providers = await setupProviders();

  runApp(MultiProvider(providers: providers, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final tokenProvider = Provider.of<TokenProvider>(context, listen: false);
    final initialRoute = tokenProvider.hasToken()
        ? MainScaffold.routeName
        : LoginScreen.routeName;

    return ToastificationWrapper(
      child: MaterialApp(
        title: '헬스온',
        theme: AppTheme.lightTheme,
        initialRoute: initialRoute,
        onGenerateRoute: (settings) {
          // 로그인이 필요없는 화면들
          final publicRoutes = [
            LoginScreen.routeName,
            SignUpScreen.routeName,
          ];

          // 토큰 체크 - 공개 화면이 아니고 토큰이 없으면 로그인으로
          if (!publicRoutes.contains(settings.name) && !tokenProvider.hasToken()) {
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          }

          // 정의된 라우트에서 찾기
          final routeBuilder = AppRoutes.routes[settings.name];
          if (routeBuilder != null) {
            return MaterialPageRoute(builder: routeBuilder);
          }

          // 라우트를 찾을 수 없으면 로그인으로
          return MaterialPageRoute(builder: (_) => const LoginScreen());
        },
      ),
    );
  }
}
