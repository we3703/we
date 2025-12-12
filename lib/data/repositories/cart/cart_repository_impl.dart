import 'dart:convert';
import 'dart:io';

import 'package:we/core/error/error_extractor.dart';
import 'package:we/core/error/failure.dart';
import 'package:we/core/error/http_exception.dart';
import 'package:we/core/error/result.dart';
import 'package:we/data/models/cart/cart.dart';
import 'package:we/data/models/common/api_response.dart';
import 'package:we/domain/repositories/cart/cart_repository.dart';
import 'package:we/data/api/product/cart_api.dart';
import 'package:we/data/models/cart/add_cart_item_request.dart';
import 'package:we/data/models/cart/update_cart_item_request.dart';

class CartRepositoryImpl implements CartRepository {
  final CartApi cartApi;

  CartRepositoryImpl(this.cartApi);

  @override
  Future<Result<void>> addCartItem(AddCartItemRequest request) async {
    try {
      await cartApi.addCartItem(request.toJson());
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
        ServerFailure('장바구니에 추가하는 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<Cart>> getCart() async {
    try {
      final response = await cartApi.getCart();
      final cart = ApiResponse.fromJson(
        response,
        Cart.fromJson,
      ).data;
      return Result.success(cart);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      final errorMessage = jsonDecode(e.body);
      if (e.statusCode == 401) {
        return Result.failure(UnauthorizedFailure(errorMessage));
      }
      return Result.failure(ServerFailure(errorMessage, e.statusCode));
    } catch (e) {
      return Result.failure(
        ServerFailure('장바구니를 불러오는 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<void>> updateCartItem(
    String itemId,
    UpdateCartItemRequest request,
  ) async {
    try {
      await cartApi.updateCartItem(itemId, request.toJson());
      return Result.success(null);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      final errorMessage = jsonDecode(e.body);
      if (e.statusCode == 401) {
        return Result.failure(UnauthorizedFailure(errorMessage));
      }
      if (e.statusCode == 404) {
        return Result.failure(ServerFailure(errorMessage, 404));
      }
      return Result.failure(ServerFailure(errorMessage, e.statusCode));
    } catch (e) {
      return Result.failure(
        ServerFailure('장바구니 수정 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<void>> deleteCartItem(String itemId) async {
    try {
      await cartApi.deleteCartItem(itemId);
      return Result.success(null);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      final errorMessage = jsonDecode(e.body);
      if (e.statusCode == 401) {
        return Result.failure(UnauthorizedFailure(errorMessage));
      }
      if (e.statusCode == 404) {
        return Result.failure(ServerFailure(errorMessage, 404));
      }
      return Result.failure(ServerFailure(errorMessage, e.statusCode));
    } catch (e) {
      return Result.failure(
        ServerFailure('장바구니 삭제 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }
}
