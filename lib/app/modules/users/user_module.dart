import 'package:scouter/scouter.dart';
import 'package:surpraise_api/app/modules/users/controllers/signup_controller.dart';
import 'package:surpraise_core/surpraise_core.dart';
import 'package:surpraise_infra/surpraise_infra.dart';

class UserModule extends Module with Injectable {
  UserModule({super.preffix = "user"});

  @override
  List<RestController> get controllers => [
        SignupController(),
      ];

  @override
  void Function()? get init => () {
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
      };
}
