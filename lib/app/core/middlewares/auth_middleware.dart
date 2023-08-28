import 'package:scouter/scouter.dart';

import '../application/application.dart';

class AuthMidleware extends HttpMiddleware {
  const AuthMidleware({
    required AuthProvider authProvider,
  }) : _authProvider = authProvider;
  final AuthProvider _authProvider;

  @override
  Future<Either<HttpResponse, void>> handle(HttpRequest request) async {
    final canGoOn = await _authProvider.checkSession(
      refreshToken: request.headers["refreshToken"],
    );
    if (canGoOn.isRight()) {
      return right(null);
    }

    return Left(
      HttpResponse(
        body: {
          "error": "Session expired",
        },
        status: 401,
      ),
    );
  }
}
