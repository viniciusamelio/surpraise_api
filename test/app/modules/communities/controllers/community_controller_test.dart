import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

import '../../../../test_application.dart';

void main() {
  group(
    "Community Controller: ",
    () {
      setUpAll(() async {
        await startTestApplication();
      });

      Future<Response> createCommunity() async {
        return await dio.post(
          "/community",
          data: {
            "ownerId": faker.guid.guid(),
            "description": faker.lorem.words(3).toString(),
            "title": "API Test",
            "planMemberLimit": 10,
          },
        );
      }

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
          final result = await createCommunity();

          expect(result.statusCode, equals(200));
          expect(result.data.containsKey("id"), isTrue);
        },
      );

      test(
        "[DELETE] /community should return payload containing error when payload contains an unknown user id",
        () async {
          final result = await dio.delete(
            "/community",
            data: {
              "id": faker.guid.guid(),
            },
          );

          expect(result.statusCode, equals(404));
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
