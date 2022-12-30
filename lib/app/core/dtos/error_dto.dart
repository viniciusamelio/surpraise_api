abstract class ErrorDto {
  static Map<String, dynamic> fromStatus(
      {required int status, required Exception exception}) {
    return {
      "httpStatus": status,
      "error": exception,
    };
  }

  static Map<String, dynamic> from400(Exception exception) =>
      fromStatus(status: 400, exception: exception);
}
