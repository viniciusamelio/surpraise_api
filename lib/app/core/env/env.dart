import 'package:dotenv/dotenv.dart';

abstract class Env {
  static late String mongoUrl;

  static Future<void> init([bool test = false]) async {
    final env = DotEnv(includePlatformEnvironment: true)
      ..load(
        test ? ["test.env"] : [".env"],
      );
    mongoUrl = env["mongo_url"] ?? String.fromEnvironment("mongo_url");
  }
}
