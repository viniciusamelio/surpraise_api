import 'package:surpraise_core/surpraise_core.dart';

class AuthResponseDto {
  const AuthResponseDto({
    required this.token,
    required this.refreshToken,
    required this.user,
  });
  final String token;
  final String refreshToken;
  final CreateUserOutput user;
}
