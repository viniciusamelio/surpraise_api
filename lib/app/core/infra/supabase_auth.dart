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
    required String sessionJson,
  }) async {
    try {
      final response = await client.auth.recoverSession(sessionJson);
      if (response.session == null || response.session!.isExpired) {
        return Left(Exception("Session expired"));
      }

      if (response.session!.expiresIn! < 200) {
        final newSession = await client.auth.refreshSession();
        return Right(
          newSession.session!.refreshToken ?? newSession.session!.accessToken,
        );
      }

      return Right(
        response.session!.refreshToken ?? response.session!.accessToken,
      );
    } catch (e) {
      return Left(Exception("Session expired"));
    }
  }

  @override
  Future<Either<Exception, String>> renewSession({
    required String sessionJson,
  }) async {
    final response = await client.auth.recoverSession(sessionJson);

    if (response.session == null) {
      return Left(Exception("Session expired"));
    }

    final newSession = await client.auth.refreshSession();
    return Right(
      newSession.session!.refreshToken ?? newSession.session!.accessToken,
    );
  }
}
