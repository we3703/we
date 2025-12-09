import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/data/models/point/recharge_points_request.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/molecules/appbar/app_header.dart';
import 'package:we/presentation/molecules/modal/point_charge_modal.dart';
import 'package:we/presentation/molecules/point/point_summary_card.dart';
import 'package:we/presentation/organisms/point/point_history_section.dart';
import 'package:we/presentation/screens/points/points_view_model.dart';

class PointManagementScreen extends StatefulWidget {
  static const routeName = '/pointManagement';

  const PointManagementScreen({super.key});

  @override
  State<PointManagementScreen> createState() => _PointManagementScreenState();
}

class _PointManagementScreenState extends State<PointManagementScreen> {
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PointsViewModel>().getPointsHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: '내 포인트 관리', showBackButton: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.layoutPadding),
        child: Consumer<PointsViewModel>(
          builder: (context, pointsVM, child) {
            if (pointsVM.isLoading && pointsVM.pointsHistory == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (pointsVM.errorMessage != null) {
              return Center(child: Text(pointsVM.errorMessage!));
            }

            final pointsHistory = pointsVM.pointsHistory;
            if (pointsHistory == null) {
              return const Center(child: Text('포인트 내역을 불러올 수 없습니다.'));
            }

            // Filter history items by type based on current tab
            List<PointHistoryItemData> historyItems;
            switch (_currentTabIndex) {
              case 0: // 충전 (CHARGE)
                historyItems = pointsHistory.history
                    .where((item) => item.type == 'CHARGE')
                    .map(
                      (item) => PointHistoryItemData(
                        title: item.description,
                        date: item.createdAt,
                        amount: '+${item.amount} P',
                        resultingBalance: '보유 포인트 ${item.balance} P',
                      ),
                    )
                    .toList();
                break;
              case 1: // 사용 (USE)
                historyItems = pointsHistory.history
                    .where((item) => item.type == 'USE')
                    .map(
                      (item) => PointHistoryItemData(
                        title: item.description,
                        date: item.createdAt,
                        amount: '-${item.amount} P',
                        resultingBalance: '보유 포인트 ${item.balance} P',
                      ),
                    )
                    .toList();
                break;
              case 2: // 수당 (COMMISSION)
                historyItems = pointsHistory.history
                    .where((item) => item.type == 'COMMISSION')
                    .map(
                      (item) => PointHistoryItemData(
                        title: item.description,
                        date: item.createdAt,
                        amount: '+${item.amount} P',
                        resultingBalance: '보유 포인트 ${item.balance} P',
                      ),
                    )
                    .toList();
                break;
              default:
                historyItems = [];
            }

            return Column(
              children: [
                PointSummaryCard(
                  currentPoints: '${pointsHistory.currentPoints} P',
                  onChargePressed: () {
                    showPointChargeModal(
                      context: context,
                      onConfirm: (amount) async {
                        final request = RechargePointsRequest(amount: amount);
                        final result = await pointsVM.rechargePoints(request);

                        if (context.mounted) {
                          Navigator.of(context).pop();

                          result.when(
                            success: (_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('포인트 충전이 완료되었습니다!'),
                                ),
                              );
                              // Refresh points history
                              pointsVM.getPointsHistory();
                            },
                            failure: (failure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(failure.message)),
                              );
                            },
                          );
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.space20),
                PointHistorySection(
                  historyItems: historyItems,
                  totalPages: 1, // TODO: Implement pagination if needed
                  onTabChanged: (index) {
                    setState(() {
                      _currentTabIndex = index;
                    });
                  },
                  onPageChanged: (page) {
                    // TODO: Handle page change if pagination is implemented
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
