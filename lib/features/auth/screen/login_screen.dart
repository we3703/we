import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:we/core/config/constant.dart';
import 'package:we/core/theme/colors.dart';
import 'package:we/core/theme/spacing.dart';
import 'package:we/core/theme/typography.dart';
import 'package:we/core/utils/toast_service.dart';
import 'package:we/core/widgets/button/primary_button.dart';
import 'package:we/core/widgets/input/custom_input.dart';
import 'package:we/features/auth/screen/signup_screen.dart';
import 'package:we/features/auth/viewmodel/login_viewmodel.dart';
import 'package:we/presentation/screens/admin/admin_scaffold.dart';
import 'package:we/presentation/screens/main/main_scaffold.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ToastService.showToast('아이디와 비밀번호를 입력해주세요.');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final loginViewModel = Provider.of<LoginViewModel>(
        context,
        listen: false,
      );
      final loginEntity = await loginViewModel.login(email, password);

      if (!mounted) return;

      Navigator.of(context).pushReplacementNamed(
        loginEntity.user.role == 'ADMIN'
            ? AdminScaffold.routeName
            : MainScaffold.routeName,
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  void _handleSignUp() {
    Navigator.pushNamed(context, SignupScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height:
                size.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom,
            child: Column(
              children: [
                // 상단 부분
                Expanded(
                  flex: 5,
                  child: Stack(
                    children: [
                      // Background Image
                      Positioned.fill(
                        child: ClipRRect(
                          child: Image.asset(
                            AppConstant.background,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Content
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.space32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Logo
                              SvgPicture.asset(
                                AppConstant.logoPath,
                                width: 64,
                                height: 64,
                              ),
                              const SizedBox(height: AppSpacing.space24),
                              // Welcome Text
                              Text(
                                '헬스온 서비스에',
                                style: AppTextStyles.heading2Bold.copyWith(
                                  color: AppColors.textInverse,
                                ),
                              ),
                              Text(
                                '오신 것을',
                                style: AppTextStyles.heading2Bold.copyWith(
                                  color: AppColors.textInverse,
                                ),
                              ),
                              Text(
                                '환영합니다.',
                                style: AppTextStyles.heading2Bold.copyWith(
                                  color: AppColors.textInverse,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // 입력 부분
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.space24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: AppSpacing.space16),

                        // Email Input
                        CustomInput(
                          controller: _emailController,
                          placeholder: '아이디를 입력해주세요.',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: AppSpacing.space16),

                        // Password Input
                        CustomInput(
                          controller: _passwordController,
                          placeholder: '비밀번호를 입력해주세요.',
                          obscureText: true,
                        ),
                        const SizedBox(height: AppSpacing.space24),

                        // Error Message
                        if (_errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppSpacing.space16,
                            ),
                            child: Text(
                              _errorMessage!,
                              style: AppTextStyles.subRegular.copyWith(
                                color: AppColors.error,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                        // Login Button
                        PrimaryButton(
                          text: _isLoading ? '로그인 중...' : '로그인',
                          onPressed: _isLoading ? null : _handleLogin,
                          variant: _isLoading
                              ? ButtonVariant.disabled
                              : ButtonVariant.primary,
                        ),
                        const SizedBox(height: AppSpacing.space16),

                        // Sign Up Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '계정을 만드시려면?  ',
                              style: AppTextStyles.subRegular,
                            ),
                            GestureDetector(
                              onTap: _handleSignUp,
                              child: Text(
                                '회원가입',
                                style: AppTextStyles.subBold.copyWith(
                                  color: AppColors.primaryDefault,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
