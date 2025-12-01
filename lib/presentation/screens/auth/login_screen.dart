import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/presentation/organisms/auth/login_form.dart';
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
  final GlobalKey<LoginFormState> _loginFormKey = GlobalKey<LoginFormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<LoginViewModel>(context, listen: false);
      viewModel.reset();

      Future.microtask(() {
        _loginFormKey.currentState?.clearInputs();
      });
    });
  }

  void _handleLogin(String email, String password) {
    final viewModel = Provider.of<LoginViewModel>(context, listen: false);
    viewModel.login(email, password);
  }

  void _handleSignUp() {
    Navigator.of(context).pushNamed(SignUpScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.loggedInUser != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacementNamed(MainScaffold.routeName);
            });
          }

          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 80),
                    Center(
                      child: Image.asset(
                        'assets/Logo.png',
                        height: 80,
                      ),
                    ),
                    const SizedBox(height: 60),
                    LoginForm(
                      formKey: _loginFormKey, // Pass the key
                      onLogin: _handleLogin,
                      onSignUp: _handleSignUp,
                      isLoading: viewModel.isLoading,
                      errorMessage: viewModel.errorMessage,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
