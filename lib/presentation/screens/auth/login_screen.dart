import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/core/auth/token_provider.dart';
import 'package:we/presentation/organisms/auth/login_form.dart';
import 'package:we/presentation/screens/admin/admin_scaffold.dart';
import 'package:we/presentation/screens/auth/login_view_model.dart';
import 'package:we/presentation/screens/auth/signup_screen.dart';
import 'package:we/presentation/screens/main/main_scaffold.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Check if user already has a valid token
        final tokenProvider = Provider.of<TokenProvider>(
          context,
          listen: false,
        );
        if (tokenProvider.hasToken()) {
          _hasNavigated = true;
          Navigator.of(context).pushReplacementNamed(MainScaffold.routeName);
          return;
        }

        final viewModel = Provider.of<LoginViewModel>(context, listen: false);
        viewModel.reset();
      }
    });
  }

  void _handleLogin(String userId, String password) {
    final viewModel = Provider.of<LoginViewModel>(context, listen: false);
    viewModel.login(userId, password);
  }

  void _handleSignUp() {
    Navigator.of(context).pushNamed(SignUpScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Consumer<LoginViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.loggedInUser != null && !_hasNavigated) {
            _hasNavigated = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                final role = viewModel.loggedInUser!.user.role;
                final routeName = (role == 'ADMIN')
                    ? AdminScaffold.routeName
                    : MainScaffold.routeName;
                Navigator.of(context).pushReplacementNamed(routeName);
              }
            });
          }

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 80),
                  Center(child: Image.asset('assets/Logo.png', height: 80)),
                  const SizedBox(height: 60),
                  LoginForm(
                    onLogin: _handleLogin,
                    onSignUp: _handleSignUp,
                    isLoading: viewModel.isLoading,
                    errorMessage: viewModel.errorMessage,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
