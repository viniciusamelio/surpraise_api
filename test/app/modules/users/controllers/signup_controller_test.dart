import 'package:test/test.dart';

import '../../../../test_application.dart';

void main() {
  group(
    "SignUp Controller: ",
    () {
      late String createdId;
      setUpAll(() async {
        await startTestApplication();
      });

      test(
        "[POST] /user/signup should return payload contaning created object, status 200, when object is following the expected format",
        () async {
          final result = await dio.post(
            "/user/signup",
            data: {
              "tag": "@vinicius",
              "name": "Vinicius Amélio",
              "email": "vinicius.amelio@zoho.com"
            },
          );
          createdId = result.data["id"];

          expect(result.statusCode, equals(200));
          expect(result.data["id"], isNotNull);
          expect(result.data["tag"], equals("@vinicius"));
        },
      );

      test(
        "[POST] /user/signup should return payload contaning error message when object does not follow the expected format",
        () async {
          final result = await dio.post(
            "/user/signup",
            data: {
              "hashtag": "anyStringHere",
            },
          );

          expect(result.statusCode, equals(500));
          expect(result.data.containsKey("error"), isTrue);
        },
      );

      test(
        "[POST] /user/signup should return payload contaning error message when object contains invalid value",
        () async {
          final result = await dio.post(
            "/user/signup",
            data: {
              "tag": "#vinicius",
              "name": "Vinicius Amélio",
              "email": "vinicius.amelio@zoho.com"
            },
          );

          expect(result.statusCode, equals(400));
          expect(result.data.containsKey("error"), isTrue);
        },
      );

      test(
        "[PUT] /user/signup should return a payload containing an error message when object contains an invalid value",
        () async {
          final result = await dio.put(
            "/user/signup",
            data: {
              "id": createdId,
              "tag": "@john_doe",
              "name": "John Doe",
              "email": "john@doe.com",
            },
          );
          expect(result.statusCode, equals(200));
          expect(result.data.containsKey("error"), isFalse);
          expect(result.data["name"], equals("John Doe"));
        },
      );

      test(
        "[PUT] /user/signup should return payload containing created when object is according to expected",
        () async {
          final result = await dio.put(
            "/user/signup",
            data: {
              "id": "500",
              "tag": "#invalid",
              "name": "John Doe",
              "email": "john@doe.com",
            },
          );
          expect(result.statusCode, equals(400));
          expect(result.data.containsKey("error"), isTrue);
        },
      );
    },
  );
}
