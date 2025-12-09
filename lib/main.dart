import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:we/core/routes/app_routes.dart';
import 'package:we/dependency_injection.dart'; // Import the new DI file
import 'package:we/presentation/foundations/app_theme.dart';
import 'package:we/presentation/screens/auth/login_screen.dart';

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
    return MaterialApp(
      title: 'We',
      theme: AppTheme.lightTheme,
      initialRoute: LoginScreen.routeName,
      routes: AppRoutes.routes,
    );
  }
}
