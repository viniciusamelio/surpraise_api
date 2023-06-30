import 'package:scouter/scouter.dart';
import 'package:surpraise_api/app/modules/users/controllers/signup_controller.dart';
import 'package:surpraise_api/app/modules/users/controllers/user_controller.dart';
import 'package:surpraise_core/surpraise_core.dart';
import 'package:surpraise_infra/surpraise_infra.dart';

class UserModule extends Module with Injectable {
  @override
  String? get preffix => "user";
  @override
  List<RestController> get controllers => [
        SignupController(),
        UserController(),
      ];

  @override
  Future<void> Function()? get init => () async {
        inject<UserRepository>(
          SingletonInjection(
            UserRepository(
              databaseDatasource: injected(),
            ),
          ),
        );
        inject<CreateUserUsecase>(
          FactoryInjection(
            () => DbCreateUserUsecase(
              createUserRepository: injected<UserRepository>(),
              idService: injected(),
              eventBus: injected(),
            ),
          ),
        );
        inject<EditUserUsecase>(
          FactoryInjection(
            () => DbEditUserUsecase(
              editUserRepository: injected<UserRepository>(),
            ),
          ),
        );
        inject<GetUserQuery>(
          FactoryInjection(
            () => GetUserQuery(
              databaseDatasource: injected(),
            ),
          ),
        );
        inject<GetUserByTagQuery>(
          FactoryInjection(
            () => GetUserByTagQuery(
              databaseDatasource: injected(),
            ),
          ),
        );
      };
}
