import 'dart:io';

abstract class Env {
  static late String mongoUrl;

  static Future<void> init([bool test = false]) async {
    mongoUrl = Platform.environment["mongo_url"] ??
        String.fromEnvironment("mongo_url");
  }
}
