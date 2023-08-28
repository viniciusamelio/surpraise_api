import 'dart:io';

abstract class Env {
  static late String mongoUrl;
  static late String supabaseKey;
  static late String supabaseUrl;

  static Future<void> init([bool test = false]) async {
    mongoUrl = "mongodb://localhost:27017";
    supabaseKey = String.fromEnvironment("SUPABASE_KEY");
    supabaseUrl = String.fromEnvironment("SUPABASE_URL");
  }
}
