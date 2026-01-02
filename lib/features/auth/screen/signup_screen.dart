import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/core/theme/colors.dart';
import 'package:we/core/utils/toast_service.dart';
import 'package:we/features/auth/widgets/signup/signup_header.dart';
import 'package:we/features/auth/widgets/signup/signup_step1.dart';
import 'package:we/features/auth/widgets/signup/signup_step2.dart';
import 'package:we/features/auth/viewmodel/signup_viewmodel.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = '/signup';

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Step management
  int _currentStep = 0;

  // Controllers
  final _userIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _referredByController = TextEditingController();

  // Terms agreement
  bool _agreedToTerms = false;

  // Loading and error state
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Add listeners to controllers to trigger rebuilds on text changes
    void listener() => setState(() {});
    _userIdController.addListener(listener);
    _passwordController.addListener(listener);
    _passwordConfirmController.addListener(listener);
    _nameController.addListener(listener);
    _phoneController.addListener(listener);
    _referredByController.addListener(listener);
  }

  @override
  void dispose() {
    _userIdController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _referredByController.dispose();
    super.dispose();
  }

  // Validation methods
  bool _isStep1Valid() {
    return _userIdController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _passwordConfirmController.text.isNotEmpty &&
        _passwordController.text == _passwordConfirmController.text;
  }

  String? _getPasswordError() {
    if (_passwordConfirmController.text.isEmpty) {
      return null;
    }
    if (_passwordController.text != _passwordConfirmController.text) {
      return '비밀번호가 일치하지 않습니다';
    }
    return null;
  }

  bool _isStep2Valid() {
    return _nameController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _agreedToTerms;
  }

  // Navigation methods
  void _goToNextStep() {
    if (_isStep1Valid()) {
      setState(() => _currentStep = 1);
    }
  }

  void _goToPreviousStep() {
    setState(() => _currentStep = 0);
  }

  // Signup handler
  Future<void> _handleSignup() async {
    if (!_isStep2Valid()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final signupViewModel = Provider.of<SignUpViewModel>(
        context,
        listen: false,
      );
      await signupViewModel.signup(
        userId: _userIdController.text,
        password: _passwordController.text,
        memberName: _nameController.text,
        phone: _phoneController.text,
        referredBy: _referredByController.text.isEmpty
            ? null
            : _referredByController.text,
      );

      if (!mounted) return;

      ToastService.showSuccess('회원가입이 완료되었습니다');
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
        _isLoading = false;
      });

      ToastService.showToast(_errorMessage!);
    }
  }

  // Terms dialog
  void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('개인정보 수집 및 이용 동의'),
        content: const SingleChildScrollView(
          child: Text(
            '본 약관은 개인정보 수집 및 이용에 관한 내용입니다.\n\n'
            '수집하는 개인정보 항목:\n'
            '- 이름, 전화번호, 아이디\n\n'
            '수집 및 이용 목적:\n'
            '- 서비스 제공 및 회원 관리\n\n'
            '보유 및 이용 기간:\n'
            '- 회원 탈퇴 시까지',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        if (_currentStep == 1) {
          _goToPreviousStep();
        } else {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: SizedBox(
              height:
                  size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
              child: Column(
                children: [
                  // Header
                  Expanded(
                    flex: 5,
                    child: SignupHeader(
                      onBackPressed: () {
                        if (_currentStep == 1) {
                          _goToPreviousStep();
                        } else {
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),

                  // Content
                  Expanded(
                    flex: 5,
                    child: _currentStep == 0
                        ? SignupStep1(
                            userIdController: _userIdController,
                            passwordController: _passwordController,
                            passwordConfirmController:
                                _passwordConfirmController,
                            passwordError: _getPasswordError(),
                            isValid: _isStep1Valid(),
                            isLoading: _isLoading,
                            onNext: _goToNextStep,
                          )
                        : SignupStep2(
                            nameController: _nameController,
                            phoneController: _phoneController,
                            referredByController: _referredByController,
                            agreedToTerms: _agreedToTerms,
                            onTermsChanged: (value) {
                              setState(() => _agreedToTerms = value);
                            },
                            onShowTerms: _showTermsDialog,
                            isValid: _isStep2Valid(),
                            isLoading: _isLoading,
                            onPrevious: _goToPreviousStep,
                            onSignup: _handleSignup,
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
