import 'dart:io';

import 'package:we/core/error/failure.dart';
import 'package:we/core/error/http_exception.dart';
import 'package:we/core/error/result.dart';
import 'package:we/core/error/error_extractor.dart';
import 'package:we/domain/repositories/product/product_repository.dart';
import 'package:we/data/api/product/product_api.dart';
import 'package:we/data/models/common/api_response.dart';
import 'package:we/data/models/product/create_product_request.dart';
import 'package:we/data/models/product/delete_product_response.dart';
import 'package:we/data/models/product/paginated_products.dart';
import 'package:we/data/models/product/product_detail.dart';
import 'package:we/data/models/product/update_product_request.dart';
import 'package:we/data/models/product/update_product_response.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductApi productApi;

  ProductRepositoryImpl(this.productApi);

  @override
  Future<Result<PaginatedProducts>> getProducts({
    int? page,
    int? limit,
    String? category,
    String? search,
  }) async {
    try {
      final response = await productApi.getProducts();
      final products = ApiResponse.fromJson(
        response,
        (data) => PaginatedProductsExtension.fromJson(data),
      ).data;
      return Result.success(products);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      final errorMessage = extractErrorMessage(e);
      return Result.failure(ServerFailure(errorMessage, e.statusCode));
    } catch (e) {
      return Result.failure(
        ServerFailure('상품 목록을 불러오는 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<ProductDetail>> getProductDetail(String productId) async {
    try {
      final response = await productApi.getProductDetail(productId);
      final product = ApiResponse.fromJson(
        response,
        ProductDetail.fromJson,
      ).data;
      return Result.success(product);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      final errorMessage = extractErrorMessage(e);
      if (e.statusCode == 404) {
        return Result.failure(ServerFailure(errorMessage, 404));
      }
      return Result.failure(ServerFailure(errorMessage, e.statusCode));
    } catch (e) {
      return Result.failure(
        ServerFailure('상품 정보를 불러오는 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<void>> createProduct(CreateProductRequest request) async {
    try {
      final fields = request.getMultipartFields();
      final files = await request.getMultipartFiles();
      await productApi.createProduct(fields, files);
      return Result.success(null);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      final errorMessage = extractErrorMessage(e);
      if (e.statusCode == 403) {
        return Result.failure(UnauthorizedFailure(errorMessage));
      }
      return Result.failure(ServerFailure(errorMessage, e.statusCode));
    } catch (e) {
      return Result.failure(
        ServerFailure('상품 생성 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<UpdateProductResponse>> updateProduct(
    String productId,
    UpdateProductRequest request,
  ) async {
    try {
      final fields = request.getMultipartFields();
      final files = await request.getMultipartFiles();
      final response = await productApi.updateProduct(
        productId,
        fields,
        files,
      );
      final updateResponse = UpdateProductResponse.fromJson(response);
      return Result.success(updateResponse);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      final errorMessage = extractErrorMessage(e);
      if (e.statusCode == 403) {
        return Result.failure(UnauthorizedFailure(errorMessage));
      }
      if (e.statusCode == 404) {
        return Result.failure(ServerFailure(errorMessage, 404));
      }
      return Result.failure(ServerFailure(errorMessage, e.statusCode));
    } catch (e) {
      return Result.failure(
        ServerFailure('상품 수정 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<DeleteProductResponse>> deleteProduct(String productId) async {
    try {
      final response = await productApi.deleteProduct(productId);
      final deleteResponse = DeleteProductResponse.fromJson(response);
      return Result.success(deleteResponse);
    } on SocketException {
      return Result.failure(const NetworkFailure('인터넷 연결을 확인해주세요'));
    } on CustomHttpException catch (e) {
      final errorMessage = extractErrorMessage(e);
      if (e.statusCode == 403) {
        return Result.failure(UnauthorizedFailure(errorMessage));
      }
      if (e.statusCode == 404) {
        return Result.failure(ServerFailure(errorMessage, 404));
      }
      return Result.failure(ServerFailure(errorMessage, e.statusCode));
    } catch (e) {
      return Result.failure(
        ServerFailure('상품 삭제 중 오류가 발생했습니다: ${e.toString()}'),
      );
    }
  }
}
