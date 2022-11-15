import 'package:scouter/scouter.dart';
import 'package:surpraise_api/app/core/env/env.dart';
import 'package:surpraise_backend_dependencies/surpraise_backend_dependencies.dart';
import 'package:surpraise_core/surpraise_core.dart';
import 'package:surpraise_infra/surpraise_infra.dart';

@HttpController()
class SignupController extends RestController {
  SignupController() {
    _repositoriesInjections();
    _usecasesInjections();
  }

  _usecasesInjections() {
    inject<CreateUserUsecase>(
      FactoryInjection(
        () => DbCreateUserUsecase(
          createUserRepository: injected(),
          idService: injected(),
          eventBus: injected(),
        ),
      ),
    );
  }

  _repositoriesInjections() {
    inject<DatabaseDatasource>(
      SingletonInjection(
        MongoDatasource(
          Mongo(
            Db(
              Env.mongoUrl,
            ),
          ),
        ),
      ),
    );

    inject<CreateUserRepository>(
      SingletonInjection(
        UserRepository(
          databaseDatasource: injected(),
        ),
      ),
    );
  }

  @Get("/")
  save(HttpRequest request) async {
    return {
      "ping": Env.mongoUrl,
    };
  }
}
