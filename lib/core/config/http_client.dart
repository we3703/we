import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:we/core/auth/token_provider.dart';
import 'package:we/core/error/http_exception.dart';

/// HTTP Client with automatic token injection
///
/// TokenProvider를 통해 자동으로 Authorization 헤더에 토큰을 추가합니다.
/// 토큰이 있으면 자동으로 'Bearer {token}' 형식으로 추가됩니다.
class HttpClient {
  final String baseUrl;
  final TokenProvider tokenProvider;

  HttpClient({required this.baseUrl, required this.tokenProvider});

  /// Build headers with automatic token injection
  Map<String, String> _buildHeaders(Map<String, String>? customHeaders) {
    final headers = <String, String>{'Content-Type': 'application/json'};

    // Add token if available
    if (tokenProvider.hasToken()) {
      final token = tokenProvider.accessToken;
      headers['Authorization'] = 'Bearer $token';
    }

    // Add custom headers (can override default headers)
    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }

    return headers;
  }

  http.Response _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else {
      throw CustomHttpException(
        message: 'Request failed',
        statusCode: response.statusCode,
        body: response.body,
      );
    }
  }

  Future<http.Response> delete(
    String path, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final response = await http.delete(
      Uri.parse('$baseUrl$path'),
      headers: _buildHeaders(headers),
      body: body == null ? null : jsonEncode(body),
    );
    return _processResponse(response);
  }

  Future<http.Response> put(
    String path, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final response = await http.put(
      Uri.parse('$baseUrl$path'),
      headers: _buildHeaders(headers),
      body: body == null ? null : jsonEncode(body),
    );
    return _processResponse(response);
  }

  Future<http.Response> post(
    String path, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl$path'),
      headers: _buildHeaders(headers),
      body: body == null ? null : jsonEncode(body),
    );
    return _processResponse(response);
  }

  Future<http.Response> get(String path, {Map<String, String>? headers}) async {
    final response = await http.get(
      Uri.parse('$baseUrl$path'),
      headers: _buildHeaders(headers),
    );
    return _processResponse(response);
  }

  Future<http.Response> patch(
    String path, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final response = await http.patch(
      Uri.parse('$baseUrl$path'),
      headers: _buildHeaders(headers),
      body: body == null ? null : jsonEncode(body),
    );
    return _processResponse(response);
  }

  /// Send multipart/form-data request with optional files
  Future<http.Response> postMultipart(
    String path, {
    Map<String, String>? fields,
    List<http.MultipartFile>? files,
    Map<String, String>? headers,
  }) async {
    final request = http.MultipartRequest('POST', Uri.parse('$baseUrl$path'));

    // Add authorization header
    final requestHeaders = <String, String>{};
    if (tokenProvider.hasToken()) {
      final token = tokenProvider.accessToken;
      requestHeaders['Authorization'] = 'Bearer $token';
    }

    // Add custom headers (but not Content-Type, as multipart sets it automatically)
    if (headers != null) {
      requestHeaders.addAll(headers);
    }

    request.headers.addAll(requestHeaders);

    // Add fields
    if (fields != null) {
      request.fields.addAll(fields);
    }

    // Add files
    if (files != null) {
      request.files.addAll(files);
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return _processResponse(response);
  }
}
