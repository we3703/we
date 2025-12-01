import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/molecules/appbar/app_header.dart';
import 'package:we/presentation/organisms/notice/notice_feed.dart';
import 'package:we/presentation/screens/notice/notice_detail_screen.dart';
import 'package:we/presentation/screens/notice/notice_view_model.dart';

class NoticeListScreen extends StatefulWidget {
  static const routeName = '/noticeList';

  const NoticeListScreen({super.key});

  @override
  State<NoticeListScreen> createState() => _NoticeListScreenState();
}

class _NoticeListScreenState extends State<NoticeListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NoticeViewModel>().getNotices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: '공지사항 목록', showBackButton: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.layoutPadding),
        child: Consumer<NoticeViewModel>(
          builder: (context, noticeVM, child) {
            if (noticeVM.isLoading && noticeVM.notices == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (noticeVM.errorMessage != null) {
              return Center(child: Text(noticeVM.errorMessage!));
            }

            final noticeList = noticeVM.notices;
            if (noticeList == null || noticeList.isEmpty) {
              return const Center(child: Text('공지사항이 없습니다.'));
            }

            final notices = noticeList.map((notice) {
              return NoticeItemData(
                title: notice.title,
                date: notice.createdAt,
                description: notice.content,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NoticeDetailScreen(
                        noticeId: notice.id.toString(),
                      ),
                    ),
                  );
                },
              );
            }).toList();

            return NoticeFeed(
              notices: notices,
              totalPages: 1, // TODO: Implement pagination if needed
              onPageChanged: (page) {
                // TODO: Handle page change if pagination is implemented
              },
            );
          },
        ),
      ),
    );
  }
}