import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/data/models/admin/notice/upsert_notice_request.dart';
import 'package:we/domain/entities/notice/notice_entity.dart';
import 'package:we/presentation/atoms/buttons/danger_button.dart';
import 'package:we/presentation/atoms/buttons/primary_button.dart';
import 'package:we/presentation/atoms/buttons/secondary_button.dart';
import 'package:we/presentation/atoms/inputs/text_input.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/molecules/appbar/app_header.dart';
import 'package:we/presentation/screens/admin/notice/admin_notice_view_model.dart';

class AdminNoticeScreen extends StatefulWidget {
  const AdminNoticeScreen({super.key});

  @override
  State<AdminNoticeScreen> createState() => _AdminNoticeScreenState();
}

class _AdminNoticeScreenState extends State<AdminNoticeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminNoticeViewModel>().getNotices();
    });
  }

  void _showNoticeFormDialog({NoticeEntity? notice}) {
    final titleController = TextEditingController(text: notice?.title ?? '');
    final contentController = TextEditingController(
      text: notice?.content ?? '',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          notice == null ? '공지사항 작성' : '공지사항 수정',
          style: AppTextStyles.heading3Bold,
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextInput(
                controller: titleController,
                labelText: '제목',
                hintText: '제목을 입력하세요',
                isRequired: true,
              ),
              const SizedBox(height: AppSpacing.space20),
              TextInput(
                controller: contentController,
                labelText: '내용',
                hintText: '내용을 입력하세요',
                isRequired: true,
                maxLength: 1000,
              ),
            ],
          ),
        ),
        actions: [
          SecondaryButton(text: '취소', onPressed: () => Navigator.pop(context)),
          PrimaryButton(
            text: notice == null ? '작성' : '수정',
            onPressed: () {
              final request = UpsertNoticeRequest(
                title: titleController.text,
                content: contentController.text,
              );
              if (notice == null) {
                context.read<AdminNoticeViewModel>().createAdminNotice(request);
              } else {
                context.read<AdminNoticeViewModel>().updateAdminNotice(
                  notice.id.toString(),
                  request,
                );
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmDialog(String noticeId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('삭제 확인', style: AppTextStyles.heading3Bold),
        content: Text(
          '정말로 이 공지사항을 삭제하시겠습니까?',
          style: AppTextStyles.bodyRegular,
        ),
        actions: [
          SecondaryButton(text: '취소', onPressed: () => Navigator.pop(context)),
          DangerButton(
            text: '삭제',
            onPressed: () {
              context.read<AdminNoticeViewModel>().deleteAdminNotice(noticeId);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: '공지사항 관리', showBackButton: true),
      body: Consumer<AdminNoticeViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    viewModel.errorMessage!,
                    style: AppTextStyles.bodyRegular.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space20),
                  PrimaryButton(
                    text: '다시 시도',
                    onPressed: () => viewModel.getNotices(),
                  ),
                ],
              ),
            );
          }

          final notices = viewModel.notices ?? [];

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.layoutPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '총 ${notices.length}개',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    PrimaryButton(
                      text: '새 공지사항',
                      onPressed: () => _showNoticeFormDialog(),
                      icon: Icons.add,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: notices.isEmpty
                    ? Center(
                        child: Text(
                          '공지사항이 없습니다',
                          style: AppTextStyles.bodyRegular.copyWith(
                            color: AppColors.textDisabled,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.layoutPadding,
                        ),
                        itemCount: notices.length,
                        itemBuilder: (context, index) {
                          final notice = notices[index];
                          return Card(
                            margin: const EdgeInsets.only(
                              bottom: AppSpacing.space12,
                            ),
                            child: ListTile(
                              title: Text(
                                notice.title,
                                style: AppTextStyles.bodyBold,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: AppSpacing.space8),
                                  Text(
                                    notice.content,
                                    style: AppTextStyles.subRegular.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: AppSpacing.space8),
                                  Text(
                                    '작성일: ${notice.createdAt}',
                                    style: AppTextStyles.subRegular.copyWith(
                                      color: AppColors.textDisabled,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: AppColors.textPrimary,
                                    ),
                                    onPressed: () =>
                                        _showNoticeFormDialog(notice: notice),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: AppColors.error,
                                    ),
                                    onPressed: () => _showDeleteConfirmDialog(
                                      notice.id.toString(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
