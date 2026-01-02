import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/core/theme/spacing.dart';
import 'package:we/core/utils/date_formatter.dart';
import 'package:we/core/widgets/card/purchase_card.dart';
import 'package:we/data/models/order/paginated_orders.dart';
import 'package:we/features/main/widgets/section_header.dart';
import 'package:we/presentation/screens/order/order_view_model.dart';

class PurchaseSection extends StatelessWidget {
  const PurchaseSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(title: '최근 구매 내역', onMoreTap: () {
          // TODO: 구매 내역 목록으로 네비게이션
        }),
        const SizedBox(height: AppSpacing.space24),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.layoutPadding,
          ),
          child: Selector<OrderViewModel, ({bool isLoading, PaginatedOrders? orders})>(
            selector: (_, vm) => (isLoading: vm.isLoading, orders: vm.paginatedOrders),
            builder: (context, state, child) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.orders == null || state.orders!.items.isEmpty) {
                return const Text('구매 내역이 없습니다.');
              }

              final items = state.orders!.items.take(3).toList();

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final order = items[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: AppSpacing.space12),
                    child: PurchaseCard(
                      productName: order.productName,
                      date: formatDate(order.orderedAt),
                      price: -order.totalPrice,
                      onTap: () {
                        // TODO: 주문 상세 화면으로 네비게이션
                      },
                    ),
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
