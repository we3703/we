import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/core/utils/toast_service.dart';
import 'package:we/features/auth/screen/login_screen.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/molecules/appbar/app_header.dart';
import 'package:we/presentation/organisms/auth/signup_form.dart';
import 'package:we/presentation/screens/auth/signup_view_model.dart';

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
      if (!mounted) return;
      Provider.of<SignUpViewModel>(context, listen: false).reset();
    });
  }

  void _handleSignup(
    String id,
    String password,
    String name,
    String phone,
    String? referralCode,
  ) {
    Provider.of<SignUpViewModel>(context, listen: false).signup(
      userId: id,
      password: password,
      memberName: name,
      phone: phone,
      referredBy: referralCode,
    );
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
        appBar: AppHeader(
          titleWidget: Text(
            '회원가입',
            style: AppTextStyles.heading3Bold.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          showBackButton: true,
        ),
        body: Consumer<SignUpViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.signupSuccess && !_hasNavigated) {
              _hasNavigated = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                ToastService.showSuccess('회원가입이 완료되었습니다.');
                Navigator.of(
                  context,
                ).pushReplacementNamed(LoginScreen.routeName);
              });
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.all(AppSpacing.layoutPadding),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: 500,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SignUpForm(
                              onSignUp: _handleSignup,
                              isLoading: viewModel.isLoading,
                            ),
                            if (viewModel.errorMessage != null)
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: AppSpacing.space12,
                                ),
                                child: Text(
                                  viewModel.errorMessage!,
                                  style: AppTextStyles.bodyRegular.copyWith(
                                    color: AppColors.error,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
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
