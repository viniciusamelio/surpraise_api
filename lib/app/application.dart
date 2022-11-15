import 'package:scouter/scouter.dart';
import 'package:surpraise_api/app/core/env/env.dart';
import 'package:surpraise_api/app/modules/users/user_module.dart';

final appModule = AppModule(
  modules: [
    UserModule(),
  ],
);

Future<void> startApp() async {
  await Env.init();
  await runServer(appModule, port: 8080);
}
