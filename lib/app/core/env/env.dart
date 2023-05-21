abstract class Env {
  static late String mongoUrl;

  static Future<void> init([bool test = false]) async {
    mongoUrl = String.fromEnvironment("mongo_url");
  }
}
