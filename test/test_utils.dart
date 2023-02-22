import 'package:faker/faker.dart';
import 'package:scouter/scouter.dart';
import 'test_application.dart';

Future<HttpResponse> createUser() async {
  final result = await dio.post(
    "/user/signup",
    data: {
      "tag": "@${faker.person.firstName()}",
      "name": faker.person.name(),
      "email": faker.internet.email(),
    },
  );

  return HttpResponse(body: result.data, status: result.statusCode);
}

Future<HttpResponse> createCommunity(String ownerId) async {
  final result = await dio.post(
    "/community",
    data: {
      "ownerId": ownerId,
      "description": faker.lorem.words(3).toString(),
      "title": faker.lorem.words(2).toString(),
      "planMemberLimit": 10,
    },
  );

  return HttpResponse(body: result.data, status: result.statusCode);
}
