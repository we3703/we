import 'package:we/domain/entities/user/user_entity.dart';
import 'package:we/domain/entities/auth/token_entity.dart';

class LoginEntity {
  final TokenEntity tokens;
  final UserEntity user;

  LoginEntity({required this.tokens, required this.user});
}
