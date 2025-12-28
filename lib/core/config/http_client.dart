import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:we/core/auth/token_provider.dart';
import 'package:we/core/error/http_exception.dart';
import 'package:we/data/models/common/token_response.dart';

/// HTTP Client with automatic token injection and refresh
///
/// TokenProvider를 통해 자동으로 Authorization 헤더에 토큰을 추가합니다.
/// 토큰이 있으면 자동으로 'Bearer {token}' 형식으로 추가됩니다.
/// 401 에러 발생 시 자동으로 refresh token으로 access token을 갱신합니다.
class HttpClient {
  final String baseUrl;
  final TokenProvider tokenProvider;

  bool _isRefreshing = false;
  Completer<bool>? _refreshCompleter;

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

  /// Handle token refresh when receiving 401 Unauthorized
  Future<bool> _handleUnauthorized() async {
    // If already refreshing, wait for the existing refresh to complete
    if (_isRefreshing) {
      if (_refreshCompleter != null) {
        return await _refreshCompleter!.future;
      }
      return false;
    }

    // Start refresh process
    _isRefreshing = true;
    _refreshCompleter = Completer<bool>();

    try {
      final refreshToken = tokenProvider.refreshToken;

      if (refreshToken == null || refreshToken.isEmpty) {
        debugPrint('No refresh token available');
        _refreshCompleter!.complete(false);
        return false;
      }

      debugPrint('Attempting to refresh access token...');

      // Call refresh API directly to avoid circular dependency
      final response = await http.post(
        Uri.parse('$baseUrl/auth/refresh'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refreshToken': refreshToken}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final tokenResponse = TokenResponse.fromJson(data);

        // Update tokens in TokenProvider
        await tokenProvider.setTokens(
          tokenResponse.accessToken,
          tokenResponse.refreshToken,
          tokenProvider.role ?? 'USER',
        );

        debugPrint('Access token refreshed successfully');
        _refreshCompleter!.complete(true);
        return true;
      } else {
        debugPrint('Failed to refresh token: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');

        // Clear tokens and force logout
        await tokenProvider.clearTokens();
        _refreshCompleter!.complete(false);
        return false;
      }
    } catch (e) {
      debugPrint('Error refreshing token: $e');

      // Clear tokens on error
      await tokenProvider.clearTokens();
      _refreshCompleter!.complete(false);
      return false;
    } finally {
      _isRefreshing = false;
      _refreshCompleter = null;
    }
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
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl$path'),
        headers: _buildHeaders(headers),
        body: body == null ? null : jsonEncode(body),
      );
      return _processResponse(response);
    } on CustomHttpException catch (e) {
      // Handle 401 Unauthorized - try to refresh token and retry
      if (e.statusCode == 401) {
        final refreshed = await _handleUnauthorized();
        if (refreshed) {
          // Retry the request with new token
          final response = await http.delete(
            Uri.parse('$baseUrl$path'),
            headers: _buildHeaders(headers),
            body: body == null ? null : jsonEncode(body),
          );
          return _processResponse(response);
        }
      }
      rethrow;
    }
  }

  Future<http.Response> put(
    String path, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$path'),
        headers: _buildHeaders(headers),
        body: body == null ? null : jsonEncode(body),
      );
      return _processResponse(response);
    } on CustomHttpException catch (e) {
      if (e.statusCode == 401) {
        final refreshed = await _handleUnauthorized();
        if (refreshed) {
          final response = await http.put(
            Uri.parse('$baseUrl$path'),
            headers: _buildHeaders(headers),
            body: body == null ? null : jsonEncode(body),
          );
          return _processResponse(response);
        }
      }
      rethrow;
    }
  }

  Future<http.Response> post(
    String path, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$path'),
        headers: _buildHeaders(headers),
        body: body == null ? null : jsonEncode(body),
      );
      return _processResponse(response);
    } on CustomHttpException catch (e) {
      if (e.statusCode == 401 && path != '/auth/refresh') {
        final refreshed = await _handleUnauthorized();
        if (refreshed) {
          final response = await http.post(
            Uri.parse('$baseUrl$path'),
            headers: _buildHeaders(headers),
            body: body == null ? null : jsonEncode(body),
          );
          return _processResponse(response);
        }
      }
      rethrow;
    }
  }

  Future<http.Response> get(String path, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$path'),
        headers: _buildHeaders(headers),
      );
      return _processResponse(response);
    } on CustomHttpException catch (e) {
      if (e.statusCode == 401) {
        final refreshed = await _handleUnauthorized();
        if (refreshed) {
          final response = await http.get(
            Uri.parse('$baseUrl$path'),
            headers: _buildHeaders(headers),
          );
          return _processResponse(response);
        }
      }
      rethrow;
    }
  }

  Future<http.Response> patch(
    String path, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl$path'),
        headers: _buildHeaders(headers),
        body: body == null ? null : jsonEncode(body),
      );
      return _processResponse(response);
    } on CustomHttpException catch (e) {
      if (e.statusCode == 401) {
        final refreshed = await _handleUnauthorized();
        if (refreshed) {
          final response = await http.patch(
            Uri.parse('$baseUrl$path'),
            headers: _buildHeaders(headers),
            body: body == null ? null : jsonEncode(body),
          );
          return _processResponse(response);
        }
      }
      rethrow;
    }
  }

  /// Send multipart/form-data request with optional files
  Future<http.Response> postMultipart(
    String path, {
    Map<String, String>? fields,
    List<http.MultipartFile>? files,
    Map<String, String>? headers,
  }) async {
    try {
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
    } on CustomHttpException catch (e) {
      if (e.statusCode == 401) {
        final refreshed = await _handleUnauthorized();
        if (refreshed) {
          // Retry the multipart request
          final request = http.MultipartRequest('POST', Uri.parse('$baseUrl$path'));

          final requestHeaders = <String, String>{};
          if (tokenProvider.hasToken()) {
            final token = tokenProvider.accessToken;
            requestHeaders['Authorization'] = 'Bearer $token';
          }
          if (headers != null) {
            requestHeaders.addAll(headers);
          }
          request.headers.addAll(requestHeaders);

          if (fields != null) {
            request.fields.addAll(fields);
          }
          if (files != null) {
            request.files.addAll(files);
          }

          final streamedResponse = await request.send();
          final response = await http.Response.fromStream(streamedResponse);

          return _processResponse(response);
        }
      }
      rethrow;
    }
  }

  /// Send PATCH multipart/form-data request with optional files
  Future<http.Response> patchMultipart(
    String path, {
    Map<String, String>? fields,
    List<http.MultipartFile>? files,
    Map<String, String>? headers,
  }) async {
    try {
      final request = http.MultipartRequest('PATCH', Uri.parse('$baseUrl$path'));

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
    } on CustomHttpException catch (e) {
      if (e.statusCode == 401) {
        final refreshed = await _handleUnauthorized();
        if (refreshed) {
          // Retry the multipart request
          final request = http.MultipartRequest('PATCH', Uri.parse('$baseUrl$path'));

          final requestHeaders = <String, String>{};
          if (tokenProvider.hasToken()) {
            final token = tokenProvider.accessToken;
            requestHeaders['Authorization'] = 'Bearer $token';
          }
          if (headers != null) {
            requestHeaders.addAll(headers);
          }
          request.headers.addAll(requestHeaders);

          if (fields != null) {
            request.fields.addAll(fields);
          }
          if (files != null) {
            request.files.addAll(files);
          }

          final streamedResponse = await request.send();
          final response = await http.Response.fromStream(streamedResponse);

          return _processResponse(response);
        }
      }
      rethrow;
    }
  }
}
