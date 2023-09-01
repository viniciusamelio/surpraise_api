import 'package:scouter/scouter.dart';

abstract class AuthProvider {
  Future<Either<Exception, String>> checkSession({
    required String sessionJson,
  });

  Future<Either<Exception, String>> renewSession({
    required String sessionJson,
  });
}
