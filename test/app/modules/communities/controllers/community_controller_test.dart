import 'package:faker/faker.dart';
import 'package:test/test.dart';

import '../../../../test_application.dart';
import '../../../../test_utils.dart';

void main() {
  group(
    "Community Controller: ",
    () {
      setUpAll(() async {
        await startTestApplication();
      });

      test(
        "[POST] /community should return error when object is an invalid one",
        () async {
          final result = await dio.post(
            "/community",
            data: {},
          );

          expect(result.statusCode, equals(500));
          expect(result.data.containsKey("error"), isTrue);
        },
      );

      test(
        "[POST] /community should return payload containing created object when sent object is a valid one",
        () async {
          final owner = await createUser();
          final result = await createCommunity(owner.body["id"]);

          expect(result.status, equals(200));
          expect(result.body.containsKey("id"), isTrue);
        },
      );

      test(
        "[DELETE] /community should return payload containing error when payload contains an unknown user id",
        () async {
          final result = await dio.delete(
            "/community/${faker.guid.guid().trim()}",
          );

          expect(result.statusCode, equals(400));
        },
      );

      test(
        "[POST] /members should return not found error object when trying to add members to an unexisting community",
        () async {
          final result = await dio.post(
            "/members",
            data: {
              "idCommunity": faker.guid.guid(),
              "members": [
                {
                  "idMember": faker.guid.guid(),
                  "role": "Member",
                },
              ],
            },
          );

          expect(result.statusCode, 404);
        },
      );
    },
  );
}
