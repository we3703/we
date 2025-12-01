import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/core/routes/app_routes.dart';
import 'package:we/dependency_injection.dart'; // Import the new DI file
import 'package:we/presentation/foundations/app_theme.dart';
import 'package:we/presentation/screens/auth/login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: setupProviders(), // Use the function from the DI file
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'We App',
      theme: AppTheme.lightTheme,
      initialRoute: LoginScreen.routeName,
      routes: AppRoutes.routes,
    );
  }
}
