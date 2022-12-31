import 'package:scouter/scouter.dart';
import 'package:surpraise_api/app/core/dtos/dtos.dart';
import 'package:surpraise_core/surpraise_core.dart';

@HttpController()
class CommunityController extends RestController {
  @Post("/")
  void save(@Body() CreateCommunityInput community) async {
    final usecase = injected<CreateCommunityUsecase>();
    final communityOrError = await usecase(community);

    return communityOrError.fold(
      (left) => ErrorDto.from400(left),
      (right) => right,
    );
  }

  @Delete("/:id")
  void delete(String id) async {
    final usecase = injected<DeleteCommunityUsecase>();
    final deletedCommunityOrError = await usecase(
      DeleteCommunityInput(id: id),
    );

    return deletedCommunityOrError.fold(
      (left) => ErrorDto.from400(left),
      (right) => right,
    );
  }
}
