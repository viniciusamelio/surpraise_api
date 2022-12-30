import 'package:scouter/scouter.dart';
import 'package:surpraise_api/app/core/dtos/dtos.dart';
import 'package:surpraise_core/surpraise_core.dart';

@HttpController()
class SignupController extends RestController {
  @Post("/")
  save(@Body() CreateUserInput user) async {
    final usecase = injected<CreateUserUsecase>();
    final result = await usecase(user);

    return result.fold(
      (left) => ErrorDto.from400(left),
      (right) => right,
    );
  }

  @Put("/")
  edit(@Body() EditUserInput user) async {
    final usecase = injected<EditUserUsecase>();
    final result = await usecase(user);

    return result.fold(
      (left) => ErrorDto.from400(left),
      (right) => right,
    );
  }
}
