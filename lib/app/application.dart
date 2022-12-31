import 'package:scouter/scouter.dart';
import 'package:surpraise_api/app/core/env/env.dart';
import 'package:surpraise_api/app/modules/communities/community_module.dart';
import 'package:surpraise_api/app/modules/core_module.dart';
import 'package:surpraise_api/app/modules/users/user_module.dart';

final appModule = AppModule(
  modules: [
    CoreModule(),
    UserModule(),
    CommunityModule(),
  ],
);

Future<void> startApp() async {
  await Env.init();
  await runServer(appModule, port: 8080);
}
