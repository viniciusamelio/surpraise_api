import 'package:scouter/scouter.dart';
import 'package:surpraise_api/app/core/dtos/dtos.dart';
import 'package:surpraise_core/surpraise_core.dart';
import 'package:surpraise_infra/surpraise_infra.dart';

@HttpController()
class PraiseController extends RestController {
  @Post("/")
  save(HttpRequest request) async {
    final usecase = injected<PraiseUsecase>();
    final data = request.body;
    final result = await usecase(
      PraiseInput(
        commmunityId: data["communityId"],
        message: data["message"],
        praisedId: data["praisedId"],
        praiserId: data["praiserId"],
        topic: data["topic"],
      ),
    );

    return result.fold(
      (left) => ErrorDto.from400(left),
      (right) => right,
    );
  }

  @Get("/:id")
  getById(String id) async {
    final query = injected<GetPraiseQuery>();
    final result = await query(
      GetPraiseInput(id: id),
    );

    return result.fold(
      (left) => ErrorDto.from400(left),
      (right) => HttpResponse(body: right.value),
    );
  }

  @Get("/community/:id")
  getByCommunity(String id) async {
    final query = injected<GetPraisesByCommunityQuery>();
    final result = await query(
      GetPraisesByCommunityInput(id: id),
    );

    return result.fold(
      (left) => ErrorDto.from400(left),
      (right) => HttpResponse(body: {
        "communities": right.value,
      }),
    );
  }

  @Get("/user/:id")
  getByUser(String id, @QueryParam() Map queryParams) async {
    final query = injected<GetPraisesByUserQuery>();
    final result = await query(
      GetPraisesByUserInput(
        id: id,
        asPraiser: queryParams["asPraiser"] != null
            ? queryParams["asPraiser"] == "true"
            : null,
      ),
    );

    return result.fold(
      (left) => ErrorDto.from400(left),
      (right) => HttpResponse(body: {
        "communities": right.value,
      }),
    );
  }
}
