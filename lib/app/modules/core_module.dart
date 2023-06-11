import 'package:scouter/scouter.dart';
import 'package:surpraise_api/app/core/env/env.dart';
import 'package:surpraise_backend_dependencies/surpraise_backend_dependencies.dart';
import 'package:surpraise_core/surpraise_core.dart';
import 'package:surpraise_infra/surpraise_infra.dart';

class CoreModule extends Module with Injectable {
  CoreModule({super.preffix = "core"});

  @override
  Future<void> Function()? get init => () async {
        final mongodb = (await Db.create(
          Env.mongoUrl,
        ))
          ..open(tlsAllowInvalidCertificates: true);
        inject<DatabaseDatasource>(
          SingletonInjection(
            MongoDatasource(
              Mongo(mongodb),
            ),
          ),
        );

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
      };
}
