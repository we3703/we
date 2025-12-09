import 'dart:io';

import 'package:we/core/error/failure.dart';
import 'package:we/core/error/http_exception.dart';
import 'package:we/core/error/error_extractor.dart';
import 'package:we/core/error/result.dart';
import 'package:we/data/api/order/order_api.dart';
import 'package:we/data/models/order/paginated_orders.dart';
import 'package:we/data/models/order/order_detail.dart';
import 'package:we/domain/repositories/order/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderApi orderApi;

  OrderRepositoryImpl(this.orderApi);

  @override
  Future<Result<PaginatedOrders>> getMyOrders({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await orderApi.getMyOrders(page: page, limit: limit);
      final data = response['data'] as Map<String, dynamic>? ?? response;
      final orders = PaginatedOrdersExtension.fromJson(data);
      return Result.success(orders);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      final errorMessage = extractErrorMessage(e);
      if (e.statusCode == 401) {
        return Result.failure(UnauthorizedFailure(errorMessage));
      }
      return Result.failure(ServerFailure(errorMessage, e.statusCode));
    } catch (e) {
      return Result.failure(
        ServerFailure('주문 내역을 불러오는 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<OrderDetail>> getOrderDetail(String orderId) async {
    try {
      final response = await orderApi.getOrderDetail(orderId);
      final data = response['data'] as Map<String, dynamic>? ?? response;
      final order = OrderDetail.fromJson(data);
      return Result.success(order);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      final errorMessage = extractErrorMessage(e);
      if (e.statusCode == 401) {
        return Result.failure(UnauthorizedFailure(errorMessage));
      }
      return Result.failure(ServerFailure(errorMessage, e.statusCode));
    } catch (e) {
      return Result.failure(
        ServerFailure('주문 상세를 불러오는 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<void>> createOrder(Map<String, dynamic> orderData) async {
    try {
      await orderApi.createOrder(orderData);
      return Result.success(null);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      final errorMessage = extractErrorMessage(e);
      if (e.statusCode == 401) {
        return Result.failure(UnauthorizedFailure(errorMessage));
      }
      return Result.failure(ServerFailure(errorMessage, e.statusCode));
    } catch (e) {
      return Result.failure(
        ServerFailure('주문 생성 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }
}
