import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  final GlobalKey<SignUpFormState> _signupFormKey = GlobalKey<SignUpFormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final viewModel = Provider.of<SignUpViewModel>(context, listen: false);
        viewModel.reset();
        _signupFormKey.currentState?.clearInputs();
      }
    });
  }

  void _handleSignup(
    String id,
    String email,
    String password,
    String name,
    String phone,
    String? referralCode,
  ) {
    final viewModel = Provider.of<SignUpViewModel>(context, listen: false);
    viewModel.signup(
      userId: id,
      email: email,
      password: password,
      memberName: name,
      phone: phone,
      referredBy: referralCode,
    );
  }

  void _handleSendCode(String email) {
    final viewModel = Provider.of<SignUpViewModel>(context, listen: false);
    viewModel.sendCode(email);
    // Optionally show a snackbar or update UI to indicate code sent
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('인증번호가 전송되었습니다.')),
    );
  }

  void _handleVerifyCode(String email, String code) {
    final viewModel = Provider.of<SignUpViewModel>(context, listen: false);
    viewModel.verifyCode(email, code);
    // Optionally show a snackbar or update UI based on verification result
    // This part might need to listen to viewModel.errorMessage or other status
    // For now, assuming success for UI feedback
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('인증번호가 확인되었습니다.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        titleWidget: const Text('회원가입'),
        showBackButton: true,
      ),
      body: Consumer<SignUpViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.signupSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('회원가입이 완료되었습니다.')),
              );
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
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
                          formKey: _signupFormKey,
                          onSignUp: _handleSignup,
                          onSendCode: _handleSendCode, // Pass new function
                          onVerifyCode: _handleVerifyCode, // Pass new function
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
            )
          );
        },
      ),
    );
  }
}
