import 'package:scouter/scouter.dart';
import 'package:surpraise_api/app/core/env/env.dart';
import 'package:surpraise_backend_dependencies/surpraise_backend_dependencies.dart';
import 'package:surpraise_core/surpraise_core.dart';
import 'package:surpraise_infra/surpraise_infra.dart';

@HttpController()
class SignupController extends RestController {
  SignupController() {
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
            )..open(),
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

  @Post("/")
  save(@Body() CreateUserInput user) async {
    final usecase = injected<CreateUserUsecase>();
    final result = await usecase(user);

    return result.fold(
      (left) => {
        "httpStatus": 400,
        "error": left,
      },
      (right) => right,
    );
  }
}
