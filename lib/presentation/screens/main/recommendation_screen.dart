import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:we/core/utils/date_formatter.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/molecules/cards/user/user_status_card.dart';
import 'package:we/presentation/organisms/user/recommendation_section.dart';
import 'package:we/presentation/screens/referral/referral_view_model.dart';
import 'package:we/presentation/screens/user/user_view_model.dart';

class RecommendationScreen extends StatefulWidget {
  static const routeName = '/recommendations';

  const RecommendationScreen({super.key});

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReferralViewModel>().getReferralSummary();
      // User info is already loaded from login, no need to call getMe() again
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ReferralViewModel, UserViewModel>(
      builder: (context, referralVM, userVM, child) {
        if (referralVM.isLoading && referralVM.referralSummary == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (referralVM.errorMessage != null) {
          return Center(child: Text(referralVM.errorMessage!));
        }

        final summary = referralVM.referralSummary;
        if (summary == null) {
          return const Center(child: Text('추천 정보를 불러올 수 없습니다.'));
        }

        final statsData = RecommendationStatsData(
          totalRecommendations: '${summary.totalReferrals}명',
          directRecommendations: '${summary.directReferrals}명',
          indirectRecommendations: '${summary.indirectReferrals}명',
        );

        // Convert level string to MembershipLevel enum
        MembershipLevel convertLevel(String level) {
          switch (level.toLowerCase()) {
            case 'master':
              return MembershipLevel.master;
            case 'diamond':
              return MembershipLevel.diamond;
            case 'gold':
              return MembershipLevel.gold;
            case 'silver':
              return MembershipLevel.silver;
            default:
              return MembershipLevel.bronze;
          }
        }

        final recommendedUsers = summary.referrals.map((referral) {
          return RecommendedUserData(
            name: referral.name,
            membershipLevel: convertLevel(referral.level),
            joinDate: formatDate(referral.joinedAt),
            recommendationCount: referral.subReferrals,
            profileImageUrl: null,
          );
        }).toList();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.layoutPadding),
          child: RecommendationSection(
            stats: statsData,
            onCopyLinkPressed: () async {
              // 사용자 ID 복사
              final myInfo = userVM.myInfo;
              if (myInfo != null) {
                await Clipboard.setData(
                  ClipboardData(text: myInfo.userId),
                );

                if (context.mounted) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('알림'),
                        content: Text(
                          '내 추천 ID가 복사되었습니다!\n${myInfo.userId}',
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('확인'),
                          ),
                        ],
                      );
                    },
                  );
                }
              }
            },
            recommendedUsers: recommendedUsers,
          ),
        );
      },
    );
  }
}
