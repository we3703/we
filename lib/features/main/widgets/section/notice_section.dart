import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/core/theme/spacing.dart';
import 'package:we/core/utils/date_formatter.dart';
import 'package:we/core/widgets/card/notice_card.dart';
import 'package:we/features/main/widgets/section_header.dart';
import 'package:we/presentation/screens/notice/notice_detail_screen.dart';
import 'package:we/presentation/screens/notice/notice_view_model.dart';

class NoticeSection extends StatelessWidget {
  const NoticeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(title: '새 공지사항', onMoreTap: () {
          // TODO: 공지사항 목록으로 네비게이션
        }),
        const SizedBox(height: AppSpacing.space24),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.layoutPadding,
          ),
          child: Selector<NoticeViewModel, ({bool isLoading, List<dynamic>? notices})>(
            selector: (_, vm) => (isLoading: vm.isLoading, notices: vm.notices),
            builder: (context, state, child) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.notices == null || state.notices!.isEmpty) {
                return const Text('공지사항이 없습니다.');
              }

              final items = state.notices!.take(3).toList();

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final notice = items[index];
                  return NoticeCard(
                    title: notice.title,
                    date: formatDate(notice.createdAt),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => NoticeDetailScreen(
                            noticeId: notice.id.toString(),
                          ),
                        ),
                      );
                    },
                    isFirst: index == 0,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
