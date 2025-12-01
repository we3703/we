import 'package:we/data/models/common/token_response.dart';
import 'package:we/data/models/user/user.dart';

class LoginResponseData {
  final TokenResponse tokens;
  final User user;

  LoginResponseData({required this.tokens, required this.user});

  factory LoginResponseData.fromJson(Map<String, dynamic> json) {
    return LoginResponseData(
      tokens: TokenResponse.fromJson(json['tokens'] as Map<String, dynamic>? ?? {}),
      user: User.fromJson(json['user'] as Map<String, dynamic>? ?? {}),
    );
  }

  String get accessToken => tokens.accessToken;
  String get refreshToken => tokens.refreshToken;
}
