import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/domain/entities/admin/order/admin_order_summary_entity.dart';
import 'package:we/presentation/atoms/buttons/primary_button.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/molecules/appbar/app_header.dart';
import 'package:we/presentation/screens/admin/order/admin_order_view_model.dart';

class AdminOrderScreen extends StatefulWidget {
  const AdminOrderScreen({super.key});

  @override
  State<AdminOrderScreen> createState() => _AdminOrderScreenState();
}

class _AdminOrderScreenState extends State<AdminOrderScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminOrderViewModel>().getAdminOrders();
    });
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColors.secondary;
      case 'processing':
        return AppColors.primaryBlack;
      case 'shipped':
        return AppColors.gold;
      case 'delivered':
        return AppColors.silver;
      case 'cancelled':
        return AppColors.error;
      default:
        return AppColors.textDisabled;
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return '대기중';
      case 'processing':
        return '처리중';
      case 'shipped':
        return '배송중';
      case 'delivered':
        return '배송완료';
      case 'cancelled':
        return '취소됨';
      default:
        return status;
    }
  }

  void _showOrderDetailDialog(AdminOrderSummaryEntity order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('주문 상세', style: AppTextStyles.heading3Bold),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('주문번호', order.orderId),
              const Divider(),
              _buildDetailRow('고객명', order.user.name),
              _buildDetailRow('이메일', order.user.email),
              if (order.user.phone != null)
                _buildDetailRow('전화번호', order.user.phone!),
              const Divider(),
              _buildDetailRow('상품명', order.product.name),
              _buildDetailRow('수량', '${order.quantity}개'),
              _buildDetailRow(
                '총 금액',
                '${order.totalPrice.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
              ),
              const Divider(),
              _buildDetailRow('상태', _getStatusText(order.status)),
              _buildDetailRow('주문일시', order.orderedAt),
              if (order.trackingNumber != null)
                _buildDetailRow('송장번호', order.trackingNumber!),
              if (order.shippedAt != null)
                _buildDetailRow('배송일시', order.shippedAt!),
            ],
          ),
        ),
        actions: [
          PrimaryButton(text: '닫기', onPressed: () => Navigator.pop(context)),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.space8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: AppTextStyles.subMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.subRegular.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: '주문 관리', showBackButton: true),
      body: Consumer<AdminOrderViewModel>(
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
                    onPressed: () => viewModel.getAdminOrders(),
                  ),
                ],
              ),
            );
          }

          final paginatedOrders = viewModel.paginatedAdminOrders;
          final orders = paginatedOrders?.items ?? [];

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.layoutPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '총 ${paginatedOrders?.totalCount ?? 0}개',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    if (paginatedOrders != null)
                      Text(
                        '페이지 ${paginatedOrders.currentPage}/${paginatedOrders.totalPages}',
                        style: AppTextStyles.subRegular.copyWith(
                          color: AppColors.textDisabled,
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: orders.isEmpty
                    ? Center(
                        child: Text(
                          '주문이 없습니다',
                          style: AppTextStyles.bodyRegular.copyWith(
                            color: AppColors.textDisabled,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.layoutPadding,
                        ),
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final order = orders[index];
                          return Card(
                            margin: const EdgeInsets.only(
                              bottom: AppSpacing.space12,
                            ),
                            child: InkWell(
                              onTap: () => _showOrderDetailDialog(order),
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                  AppSpacing.layoutPadding,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            order.orderId,
                                            style: AppTextStyles.bodyBold,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: AppSpacing.space8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _getStatusColor(
                                              order.status,
                                            ).withValues(alpha: 0.1),
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          child: Text(
                                            _getStatusText(order.status),
                                            style: AppTextStyles.subMedium
                                                .copyWith(
                                                  color: _getStatusColor(
                                                    order.status,
                                                  ),
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: AppSpacing.space12),
                                    Text(
                                      '고객: ${order.user.name} (${order.user.email})',
                                      style: AppTextStyles.subRegular.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: AppSpacing.space8),
                                    Text(
                                      '상품: ${order.product.name}',
                                      style: AppTextStyles.subRegular.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: AppSpacing.space8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '수량: ${order.quantity}개',
                                          style: AppTextStyles.subRegular
                                              .copyWith(
                                                color: AppColors.textDisabled,
                                              ),
                                        ),
                                        Text(
                                          '${order.totalPrice.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                                          style: AppTextStyles.bodyBold
                                              .copyWith(
                                                color: AppColors.primaryBlack,
                                              ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: AppSpacing.space8),
                                    Text(
                                      '주문일: ${order.orderedAt}',
                                      style: AppTextStyles.subRegular.copyWith(
                                        color: AppColors.textDisabled,
                                      ),
                                    ),
                                  ],
                                ),
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
