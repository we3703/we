import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/presentation/atoms/buttons/primary_button.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/molecules/appbar/app_header.dart';
import 'package:we/presentation/screens/notice/notice_view_model.dart';

class NoticeDetailScreen extends StatefulWidget {
  static const routeName = '/noticeDetail';

  final String noticeId;

  const NoticeDetailScreen({super.key, required this.noticeId});

  @override
  State<NoticeDetailScreen> createState() => _NoticeDetailScreenState();
}

class _NoticeDetailScreenState extends State<NoticeDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NoticeViewModel>().getNoticeDetail(widget.noticeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: '공지사항', showBackButton: true),
      body: SafeArea(
        child: Consumer<NoticeViewModel>(
          builder: (context, noticeVM, child) {
            if (noticeVM.isLoading && noticeVM.noticeDetail == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (noticeVM.errorMessage != null) {
              return Center(child: Text(noticeVM.errorMessage!));
            }

            final noticeDetail = noticeVM.noticeDetail;
            if (noticeDetail == null) {
              return const Center(child: Text('공지사항 정보를 불러올 수 없습니다.'));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.layoutPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(noticeDetail.title, style: AppTextStyles.heading3Bold),
                  const SizedBox(height: AppSpacing.space12),
                  Text(
                    noticeDetail.createdAt,
                    style: AppTextStyles.bodyRegular.copyWith(
                      color: AppColors.textDisabled,
                      fontSize: 12,
                    ),
                  ),
                  const Divider(height: AppSpacing.space32),
                  Text(
                    noticeDetail.content,
                    style: AppTextStyles.bodyRegular.copyWith(height: 1.6),
                  ),
                  const SizedBox(height: AppSpacing.space32),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      text: '목록으로',
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
