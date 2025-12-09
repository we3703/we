import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:we/core/auth/token_provider.dart';
import 'package:we/core/config/http_client.dart';
import 'package:we/data/api/auth/auth_api.dart';
import 'package:we/data/repositories/auth/auth_repository_impl.dart';
import 'package:we/domain/repositories/auth/auth_repository.dart';
import 'package:we/domain/use_cases/auth/login_use_case.dart';
import 'package:we/presentation/screens/auth/login_view_model.dart';

List<SingleChildWidget> setupTestProviders() {
  // Core Dependencies
  final tokenProvider = TokenProvider();
  // Use a dummy URL for testing
  final httpClient = HttpClient(
    baseUrl: "http://dummy.url",
    tokenProvider: tokenProvider,
  );

  // API Implementations
  final authApi = AuthApi(httpClient);

  // Repository Implementations
  final AuthRepository authRepository = AuthRepositoryImpl(authApi, tokenProvider);

  // Use Cases
  final LoginUseCase loginUseCase = LoginUseCase(authRepository);

  return [
    ChangeNotifierProvider<TokenProvider>.value(value: tokenProvider),
    Provider<HttpClient>.value(value: httpClient),
    Provider<AuthRepository>.value(value: authRepository),
    Provider<LoginUseCase>.value(value: loginUseCase),
    ChangeNotifierProvider(create: (_) => LoginViewModel(loginUseCase, tokenProvider)),
  ];
}

Widget createTestableWidget({required Widget child}) {
  return MultiProvider(
    providers: setupTestProviders(),
    child: MaterialApp(
      home: child,
    ),
  );
}
