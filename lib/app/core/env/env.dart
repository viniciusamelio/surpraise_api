import 'package:dotenv/dotenv.dart';

abstract class Env {
  static late String mongoUrl;

  static Future<void> init() async {
    final env = DotEnv(includePlatformEnvironment: true)..load();
    mongoUrl = env["mongo_url"] ?? String.fromEnvironment("mongo_url");
  }
}
