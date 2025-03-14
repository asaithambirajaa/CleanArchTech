class AppException implements Exception {
  final String? _message;
  final String? _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class ErrorModelException extends AppException {
  ErrorModelException([message]) : super(message, "Invalid Request: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised Request: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

class InternetConnectionException extends AppException {
  InternetConnectionException([String? message])
      : super(message, "No Internet: ");
}

class InternalServerException extends AppException {
  InternalServerException([message])
      : super(message, "Internal server error: ");
}

class SessionTimeoutException extends AppException {
  SessionTimeoutException([message]) : super(message, "Session timeout: ");
}

class SomethingWentWrongException extends AppException {
  SomethingWentWrongException([String? message])
      : super(message, "Something went wrong: ");
}

class NoDataInLocalException extends AppException {
  NoDataInLocalException([String? message]) : super(message);
}
