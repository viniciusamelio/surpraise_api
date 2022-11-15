import 'package:scouter/scouter.dart';
import 'package:surpraise_api/app/modules/users/controllers/signup_controller.dart';

class UserModule extends Module {
  UserModule({super.preffix = "user"});

  @override
  List<RestController> get controllers => [
        SignupController(),
      ];
}
