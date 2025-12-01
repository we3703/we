import 'package:flutter/foundation.dart';

/// Token Provider
///
/// 앱 전체에서 사용할 인증 토큰을 관리합니다.
/// Provider로 제공되어 전역적으로 접근 가능합니다.
///
/// Usage:
/// ```dart
/// // Token 설정
/// context.read<TokenProvider>().setTokens('access_token', 'refresh_token');
///
/// // Token 가져오기
/// final token = context.read<TokenProvider>().accessToken;
///
/// // Token 제거 (로그아웃)
/// context.read<TokenProvider>().clearTokens();
/// ```
class TokenProvider extends ChangeNotifier {
  String? _accessToken;
  String? _refreshToken;

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

  bool get isLoggedIn => _accessToken != null;

  /// Set authentication tokens
  void setTokens(String accessToken, String refreshToken) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    notifyListeners();
  }

  /// Update only access token (for refresh)
  void setAccessToken(String accessToken) {
    _accessToken = accessToken;
    notifyListeners();
  }

  /// Clear all tokens (logout)
  void clearTokens() {
    _accessToken = null;
    _refreshToken = null;
    notifyListeners();
  }

  /// Check if user has valid token
  bool hasToken() {
    return _accessToken != null && _accessToken!.isNotEmpty;
  }
}
