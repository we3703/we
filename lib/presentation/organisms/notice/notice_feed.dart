import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/molecules/cards/notice/notice_card.dart';
import 'package:we/presentation/molecules/indicator/page_indicator.dart';

// Data model for a single notice item
class NoticeItemData {
  final String title;
  final String date;
  final String description;
  final VoidCallback? onTap;

  NoticeItemData({
    required this.title,
    required this.date,
    required this.description,
    this.onTap,
  });
}

class NoticeFeed extends StatefulWidget {
  final List<NoticeItemData> notices;
  final int totalPages;
  final int initialPage;
  final Function(int page) onPageChanged;

  const NoticeFeed({
    super.key,
    required this.notices,
    required this.totalPages,
    this.initialPage = 1,
    required this.onPageChanged,
  });

  @override
  State<NoticeFeed> createState() => _NoticeFeedState();
}

class _NoticeFeedState extends State<NoticeFeed> {
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.notices.length,
          itemBuilder: (context, index) {
            final notice = widget.notices[index];
            return NoticeCard(
              title: notice.title,
              date: notice.date,
              description: notice.description,
              onTap: notice.onTap,
            );
          },
          separatorBuilder: (context, index) =>
              const SizedBox(height: AppSpacing.space12),
        ),
        if (widget.totalPages > 1) ...[
          const SizedBox(height: AppSpacing.space32),
          PageIndicator(
            currentPage: _currentPage,
            totalPages: widget.totalPages,
            onPageChanged: (page) {
              setState(() {
                _currentPage = page;
              });
              widget.onPageChanged(page);
            },
          ),
        ],
      ],
    );
  }
}
