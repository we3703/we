import 'dart:io';

import 'package:we/core/error/failure.dart';
import 'package:we/core/error/http_exception.dart';
import 'package:we/core/error/result.dart';
import 'package:we/core/error/error_extractor.dart';
import 'package:we/domain/repositories/admin/admin_order_repository.dart';
import 'package:we/data/api/admin/admin_order_api.dart';
import 'package:we/data/models/common/api_response.dart';
import 'package:we/data/models/admin/order/paginated_admin_orders.dart';

class AdminOrderRepositoryImpl implements AdminOrderRepository {
  final AdminOrderApi adminOrderApi;

  AdminOrderRepositoryImpl(this.adminOrderApi);

  @override
  Future<Result<PaginatedAdminOrders>> getAdminOrders() async {
    try {
      final response = await adminOrderApi.getAdminOrders();
      final orders = ApiResponse.fromJson(
        response,
        (data) => PaginatedAdminOrdersExtension.fromJson(data),
      ).data;
      return Result.success(orders);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      final errorMessage = extractErrorMessage(e);
      if (e.statusCode == 401) {
        return Result.failure(UnauthorizedFailure(errorMessage));
      }
      if (e.statusCode == 403) {
        return Result.failure(UnauthorizedFailure(errorMessage));
      }
      return Result.failure(ServerFailure(errorMessage, e.statusCode));
    } catch (e) {
      return Result.failure(
        ServerFailure('주문 목록을 불러오는 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }
}
