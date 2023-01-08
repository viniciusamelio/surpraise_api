import 'package:dio/dio.dart';
import 'package:scouter/scouter.dart';
import 'package:surpraise_api/app/application.dart';
import 'package:surpraise_api/app/core/env/env.dart';

Future<void> startTestApplication() async {
  await Env.init(true);
  await runServer(appModule, port: 8080);
}

final dio = Dio(
  BaseOptions(
    baseUrl: "http://localhost:8080",
    receiveDataWhenStatusError: true,
    validateStatus: (status) => true,
  ),
);
