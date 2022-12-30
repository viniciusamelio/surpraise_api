import 'package:scouter/scouter.dart';
import 'package:surpraise_api/app/core/env/env.dart';
import 'package:surpraise_backend_dependencies/surpraise_backend_dependencies.dart';
import 'package:surpraise_core/surpraise_core.dart';
import 'package:surpraise_infra/surpraise_infra.dart';

class CoreModule extends Module with Injectable {
  CoreModule({super.preffix = "core"});

  @override
  void Function()? get init => () {
        inject<EventBus>(
          SingletonInjection(
            StreamEventBus(),
          ),
        );
        inject<IdService>(
          SingletonInjection(
            UuidService(),
          ),
        );
        inject<DatabaseDatasource>(
          SingletonInjection(
            MongoDatasource(
              Mongo(
                Db(
                  Env.mongoUrl,
                )..open(),
              ),
            ),
          ),
        );
      };
}
