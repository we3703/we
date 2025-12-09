import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/molecules/appbar/app_header.dart';
import 'package:we/presentation/organisms/purchase/purchase_history_list.dart';
import 'package:we/presentation/screens/order/order_view_model.dart';
import 'package:we/presentation/screens/product/product_detail_screen.dart';

class PurchaseHistoryScreen extends StatefulWidget {
  static const routeName = '/purchaseHistory';

  const PurchaseHistoryScreen({super.key});

  @override
  State<PurchaseHistoryScreen> createState() => _PurchaseHistoryScreenState();
}

class _PurchaseHistoryScreenState extends State<PurchaseHistoryScreen> {
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderViewModel>().getMyOrders(page: _currentPage, limit: 10);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: '구매 내역', showBackButton: true),
      body: Consumer<OrderViewModel>(
        builder: (context, orderVM, child) {
          if (orderVM.isLoading && orderVM.paginatedOrders == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (orderVM.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.layoutPadding),
                child: Text(orderVM.errorMessage!),
              ),
            );
          }

          final paginatedOrders = orderVM.paginatedOrders;
          if (paginatedOrders == null || paginatedOrders.items.isEmpty) {
            return const Center(child: Text('구매 내역이 없습니다.'));
          }

          final purchasedItems = paginatedOrders.items.map((order) {
            return PurchasedItemData(
              imageUrl: order.productImage.isNotEmpty
                  ? order.productImage
                  : 'https://via.placeholder.com/200',
              productName: order.productName,
              price: order.totalPrice,
              purchaseDate: order.orderedAt,
              onRepurchasePressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailScreen(productId: order.productId),
                  ),
                );
              },
            );
          }).toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.layoutPadding),
            child: PurchaseHistoryList(
              purchasedItems: purchasedItems,
              totalPages: paginatedOrders.totalPages,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
                context.read<OrderViewModel>().getMyOrders(
                  page: page,
                  limit: 10,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
