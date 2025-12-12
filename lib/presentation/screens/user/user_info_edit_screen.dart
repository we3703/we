import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/core/utils/toast_service.dart';
import 'package:we/data/models/user/update_my_info_request.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/molecules/appbar/app_header.dart';
import 'package:we/presentation/organisms/user/user_info_form.dart';
import 'package:we/presentation/screens/user/user_view_model.dart';

class UserInfoEditScreen extends StatefulWidget {
  static const routeName = '/userInfoEdit';

  const UserInfoEditScreen({super.key});

  @override
  State<UserInfoEditScreen> createState() => _UserInfoEditScreenState();
}

class _UserInfoEditScreenState extends State<UserInfoEditScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserViewModel>().getMe();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const AppHeader(title: '내 정보 수정', showBackButton: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: AppSpacing.layoutPadding,
          right: AppSpacing.layoutPadding,
          top: AppSpacing.layoutPadding,
          bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.layoutPadding,
        ),
        child: Consumer<UserViewModel>(
          builder: (context, userVM, child) {
            if (userVM.isLoading && userVM.myInfo == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (userVM.errorMessage != null) {
              return Center(child: Text(userVM.errorMessage!));
            }

            final myInfo = userVM.myInfo;
            if (myInfo == null) {
              return const Center(child: Text('사용자 정보를 불러올 수 없습니다.'));
            }

            return UserInfoForm(
              initialName: myInfo.name,
              initialPhone: myInfo.phone ?? '',
              onSave: (name, phone, oldPassword, newPassword) async {
                // TODO: Password update is not implemented in the request model yet
                // Only updating name and phone for now
                final request = UpdateMyInfoRequest(
                  memberName: name,
                  phone: phone,
                );

                await context.read<UserViewModel>().updateMe(request);

                if (!context.mounted) return;

                final viewModel = context.read<UserViewModel>();
                if (viewModel.errorMessage == null) {
                  ToastService.showSuccess('정보가 저장되었습니다.');
                  Navigator.of(context).pop();
                } else {
                  ToastService.showError(viewModel.errorMessage!);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
