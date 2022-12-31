import 'package:scouter/scouter.dart';
import 'package:surpraise_api/app/modules/communities/controllers/community_controller.dart';
import 'package:surpraise_core/surpraise_core.dart';
import 'package:surpraise_infra/surpraise_infra.dart';

class CommunityModule extends Module with Injectable {
  CommunityModule();

  @override
  List<RestController> get controllers => [
        CommunityController(),
      ];

  @override
  void Function() get init => () {
        inject<CommunityRepository>(
          SingletonInjection(
            CommunityRepository(
              databaseDatasource: injected(),
            ),
          ),
        );
        inject<CreateCommunityUsecase>(
          FactoryInjection(
            () => DbCreateCommunityUsecase(
              createCommunityRepository: injected<CommunityRepository>(),
              idService: injected(),
              eventBus: injected(),
            ),
          ),
        );
      };
}
