import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/core/utils/toast_service.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/molecules/appbar/app_header.dart';
import 'package:we/presentation/organisms/auth/signup_form.dart';
import 'package:we/presentation/screens/auth/signup_view_model.dart';
import 'package:we/presentation/screens/auth/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final viewModel = Provider.of<SignUpViewModel>(context, listen: false);
        viewModel.reset();
      }
    });
  }

  void _handleSignup(
    String id,
    String password,
    String name,
    String phone,
    String? referralCode,
  ) {
    final viewModel = Provider.of<SignUpViewModel>(context, listen: false);
    viewModel.signup(
      userId: id,
      password: password,
      memberName: name,
      phone: phone,
      referredBy: referralCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppHeader(titleWidget: const Text('회원가입'), showBackButton: true),
      body: Consumer<SignUpViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.signupSuccess && !_hasNavigated) {
            _hasNavigated = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                ToastService.showSuccess('회원가입이 완료되었습니다.');
                Navigator.of(
                  context,
                ).pushReplacementNamed(LoginScreen.routeName);
              }
            });
          }

          return SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.layoutPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SignUpForm(
                          onSignUp: _handleSignup,
                          isLoading: viewModel.isLoading,
                        ),
                        if (viewModel.errorMessage != null)
                          Padding(
                            padding: EdgeInsets.only(top: AppSpacing.space12),
                            child: Text(
                              viewModel.errorMessage!,
                              style: TextStyle(color: AppColors.error),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
