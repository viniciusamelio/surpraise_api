import 'package:scouter/scouter.dart';
import 'package:supabase/supabase.dart';
import 'package:surpraise_api/app/core/application/protocols/protocols.dart';
import 'package:surpraise_api/app/core/env/env.dart';
import 'package:surpraise_api/app/core/infra/supabase_auth.dart';
import 'package:surpraise_api/app/core/middlewares/auth_middleware.dart';
import 'package:surpraise_backend_dependencies/surpraise_backend_dependencies.dart';
import 'package:surpraise_core/surpraise_core.dart';
import 'package:surpraise_infra/surpraise_infra.dart';

class CoreModule extends Module with Injectable {
  CoreModule({super.preffix = "core"});

  @override
  Future<void> Function()? get init => () async {
        final mongodb = (Db(
          Env.mongoUrl,
        ))
          ..open();
        inject<DatabaseDatasource>(
          SingletonInjection(
            MongoDatasource(
              Mongo(mongodb),
              Env.mongoUrl,
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
        inject<AuthProvider>(
          SingletonInjection(
            SupabaseAuthProvider(
              client: SupabaseClient(
                Env.supabaseUrl,
                Env.supabaseKey,
              ),
            ),
          ),
        );
        inject<AuthMidleware>(
          FactoryInjection(
            () => AuthMidleware(
              authProvider: injected(),
            ),
          ),
        );
      };
}
