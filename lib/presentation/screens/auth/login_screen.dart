import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/core/auth/token_provider.dart';
import 'package:we/presentation/foundations/image.dart';
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
      if (!mounted) return;

      final tokenProvider =
          Provider.of<TokenProvider>(context, listen: false);

      if (tokenProvider.hasToken()) {
        _hasNavigated = true;
        Navigator.of(context).pushReplacementNamed(
          tokenProvider.role == 'ADMIN'
              ? AdminScaffold.routeName
              : MainScaffold.routeName,
        );
        return;
      }

      Provider.of<LoginViewModel>(context, listen: false).reset();
    });
  }

  void _handleLogin(String userId, String password) {
    Provider.of<LoginViewModel>(context, listen: false)
        .login(userId, password);
  }

  void _handleSignUp() {
    Navigator.of(context).pushNamed(SignUpScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        FocusScope.of(context).unfocus();
        Navigator.of(context).pop();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Consumer<LoginViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.loggedInUser != null && !_hasNavigated) {
            _hasNavigated = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              Navigator.of(context).pushReplacementNamed(
                viewModel.loggedInUser!.user.role == 'ADMIN'
                    ? AdminScaffold.routeName
                    : MainScaffold.routeName,
              );
            });
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: 420,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 48),
                          Center(
                            child: Image.asset(
                              ImageStorage.logo,
                              height: 80,
                            ),
                          ),
                          const SizedBox(height: 48),
                          LoginForm(
                            onLogin: _handleLogin,
                            onSignUp: _handleSignUp,
                            isLoading: viewModel.isLoading,
                            errorMessage: viewModel.errorMessage,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    ),
    );
  }
}