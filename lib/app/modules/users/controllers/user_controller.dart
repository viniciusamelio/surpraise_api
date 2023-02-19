import 'package:scouter/scouter.dart';
import 'package:surpraise_infra/surpraise_infra.dart';

import '../../../core/dtos/error_dto.dart';

@HttpController()
class UserController extends RestController {
  @Get("/:id")
  get(String id) async {
    final query = injected<GetUserQuery>();
    final result = await query(
      GetUserQueryInput(
        id: id,
      ),
    );

    return result.fold(
      (left) => ErrorDto.from400(left),
      (right) => HttpResponse(body: right.value),
    );
  }
}
