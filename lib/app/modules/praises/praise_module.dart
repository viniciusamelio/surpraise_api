import 'package:scouter/scouter.dart';
import 'package:surpraise_api/app/modules/praises/controllers/praise_controller.dart';
import 'package:surpraise_core/surpraise_core.dart';
import 'package:surpraise_infra/surpraise_infra.dart';

import '../../core/middlewares/auth_middleware.dart';

class PraiseModule extends Module with Injectable {
  @override
  List<RestController> get controllers => [PraiseController()];

  @override
  List<HttpMiddleware> get middlewares => [injected<AuthMidleware>()];

  @override
  Future<void> Function()? get init => () async {
        inject<PraiseRepository>(
          FactoryInjection(
            () => PraiseRepository(
              datasource: injected(),
            ),
          ),
        );

        inject<PraiseUsecase>(
          FactoryInjection(
            () => DbPraiseUsecase(
              createPraiseRepository: injected<PraiseRepository>(),
              idService: injected(),
              findPraiseUsersRepository: injected<PraiseRepository>(),
              eventBus: injected(),
            ),
          ),
        );

        inject<GetPraiseQuery>(
          FactoryInjection(
            () => GetPraiseQuery(
              databaseDatasource: injected(),
            ),
          ),
        );

        inject<GetPraisesByUserQuery>(
          FactoryInjection(
            () => GetPraisesByUserQuery(
              databaseDatasource: injected(),
            ),
          ),
        );

        inject<GetPraisesByCommunityQuery>(
          FactoryInjection(
            () => GetPraisesByCommunityQuery(
              databaseDatasource: injected(),
            ),
          ),
        );
      };
}
