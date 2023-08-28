import 'package:scouter/scouter.dart';
import 'package:supabase/supabase.dart';

import '../application/application.dart';

class SupabaseAuthProvider implements AuthProvider {
  const SupabaseAuthProvider({
    required this.client,
  });
  final SupabaseClient client;

  @override
  Future<Either<Exception, String>> checkSession({
    required String refreshToken,
  }) async {
    try {
      final response = await client.auth.setSession(refreshToken);
      if (response.session == null) {
        return left(AuthException("Session expired"));
      }

      if (response.session!.expiresIn! < 120) {
        final newSession = await client.auth.refreshSession();
        return Right(
          newSession.session!.refreshToken ?? newSession.session!.accessToken,
        );
      }

      return Right(
        response.session!.refreshToken ?? response.session!.accessToken,
      );
    } catch (e) {
      return left(AuthException("Session expired"));
    }
  }

  @override
  Future<Either<Exception, String>> renewSession({
    required String sessionJson,
  }) async {
    final response = await client.auth.recoverSession(sessionJson);

    if (response.session == null) {
      return left(AuthException("Session expired"));
    }

    final newSession = await client.auth.refreshSession();
    return Right(
      newSession.session!.refreshToken ?? newSession.session!.accessToken,
    );
  }
}
