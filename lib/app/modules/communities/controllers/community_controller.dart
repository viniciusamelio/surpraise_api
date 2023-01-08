import 'package:scouter/scouter.dart';
import 'package:surpraise_core/surpraise_core.dart';

import 'package:surpraise_api/app/core/dtos/dtos.dart';
import 'package:surpraise_api/app/modules/communities/mappers/member_mapper.dart';

import '../dtos/dtos.dart';

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

  @Post("/members")
  void addMembers(HttpRequest request) async {
    final usecase = injected<AddMembersUsecase>();
    final addedMembersOrError = await usecase(
      MemberMapper.fromMap(request.body),
    );

    return addedMembersOrError.fold(
      (left) => ErrorDto.from400(left),
      (right) => right,
    );
  }

  @Patch("/members/remove")
  void removeMembers(@Body() RemoveMembersDto input) async {
    final usecase = injected<RemoveMembersUsecase>();
    final removedMembersResultOrError = await usecase(
      RemoveMembersInput(
        communityId: input.communityId,
        memberIds: input.memberIds.cast<String>(),
      ),
    );

    return removedMembersResultOrError.fold(
      (left) => ErrorDto.from400(left),
      (right) => right,
    );
  }
}
