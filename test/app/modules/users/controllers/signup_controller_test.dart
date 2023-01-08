import 'package:test/test.dart';

import '../../../../test_application.dart';

void main() {
  group(
    "SignUp Controller: ",
    () {
      setUpAll(() async {
        await startTestApplication();
      });

      test(
        "/user/signup should return payload contaning created object, status 200, when object is following the expected format",
        () async {
          final result = await dio.post(
            "/user/signup",
            data: {
              "tag": "@vinicius",
              "name": "Vinicius Amélio",
              "email": "vinicius.amelio@zoho.com"
            },
          );

          expect(result.statusCode, equals(200));
          expect(result.data["id"], isNotNull);
          expect(result.data["tag"], equals("@vinicius"));
        },
      );

      test(
        "/user/signup should return payload contaning error message when object does not follow the expected format",
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
        "/user/signup should return payload contaning error message when object contains invalid value",
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
    },
  );
}
