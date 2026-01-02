import 'package:flutter/material.dart';
import 'package:we/core/theme/spacing.dart';
import 'package:we/core/widgets/card/notice_card.dart';
import 'package:we/features/main/widgets/section_header.dart';

class NoticeSection extends StatelessWidget {
  const NoticeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(title: '새 공지사항', onMoreTap: () {}),
        SizedBox(height: AppSpacing.space24),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.layoutPadding,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return NoticeCard(
                title: '[공지] 공지사항 제목',
                date: '0000-00-00 (요일)',
                onTap: () {},
                isFirst: index == 0,
              );
            },
          ),
        ),
      ],
    );
  }
}
