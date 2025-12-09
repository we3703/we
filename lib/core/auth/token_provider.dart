import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Token Provider
///
/// 앱 전체에서 사용할 인증 토큰을 관리합니다.
/// Provider로 제공되어 전역적으로 접근 가능합니다.
/// SharedPreferences를 사용하여 영구 저장합니다.
///
/// Usage:
/// ```dart
/// // Token 설정
/// await context.read<TokenProvider>().setTokens('access_token', 'refresh_token');
///
/// // Token 가져오기
/// final token = context.read<TokenProvider>().accessToken;
///
/// // Token 제거 (로그아웃)
/// await context.read<TokenProvider>().clearTokens();
/// ```
class TokenProvider extends ChangeNotifier {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  String? _accessToken;
  String? _refreshToken;

  String? get accessToken => _accessToken;

  String? get refreshToken => _refreshToken;

  bool get isLoggedIn => _accessToken != null;

  /// Initialize and load tokens from storage
  Future<void> loadTokens() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _accessToken = prefs.getString(_accessTokenKey);
      _refreshToken = prefs.getString(_refreshTokenKey);
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading tokens: $e');
    }
  }

  /// Set authentication tokens
  Future<void> setTokens(String accessToken, String refreshToken) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_accessTokenKey, accessToken);
      await prefs.setString(_refreshTokenKey, refreshToken);

      _accessToken = accessToken;
      _refreshToken = refreshToken;

      notifyListeners();
    } catch (e) {
      debugPrint('Error saving tokens: $e');
    }
  }

  /// Update only access token (for refresh)
  Future<void> setAccessToken(String accessToken) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_accessTokenKey, accessToken);
      _accessToken = accessToken;
      notifyListeners();
    } catch (e) {
      debugPrint('Error updating access token: $e');
    }
  }

  /// Clear all tokens (logout)
  Future<void> clearTokens() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_accessTokenKey);
      await prefs.remove(_refreshTokenKey);
      _accessToken = null;
      _refreshToken = null;
      notifyListeners();
    } catch (e) {
      debugPrint('Error clearing tokens: $e');
    }
  }

  /// Check if user has valid token
  bool hasToken() {
    return _accessToken != null && _accessToken!.isNotEmpty;
  }
}
