import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../core.dart';

enum FailureStatus {
  tokenFailure,
  networkFailure,
  dataNotFetched,
  badRequest,
  unauthorized,
  somethingWentWrong,
  internalServerFailure,
  connectionTimeout,
  sendTimeout,
  receiveTimeout,
  badCertificate,
  badResponse,
  pageNotFound,
  cancel,
  connectionError,
  unknown,
  validationError,
  errorModel,
}

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class NetworkConnectionErrorState extends Failure {}

class NetworkFailure extends Failure {
  NetworkFailure();
}

class ServerFailure extends Failure {
  final FailureStatus status;
  final String message;
  ServerFailure({required this.status, this.message = ""});

  @override
  List<Object> get props => [status, message];
}

class ValidationFailure extends Failure {
  final String message;
  ValidationFailure(this.message);

  @override
  List<Object> get props => [message];
}

class ResponseFailure extends Failure {
  final String message;

  ResponseFailure(this.message);

  @override
  List<Object> get props => [message];
}

ServerFailure handleException(dynamic e) {
  if (e is BadRequestException) {
    return ServerFailure(
      status: FailureStatus.badRequest,
      message: e.toString(),
    );
  } else if (e is UnauthorisedException) {
    return ServerFailure(
      status: FailureStatus.unauthorized,
      message: e.toString(),
    );
  } else if (e is FetchDataException) {
    return ServerFailure(
      status: FailureStatus.dataNotFetched,
      message: e.toString(),
    );
  } else if (e is InternalServerException) {
    return ServerFailure(
      status: FailureStatus.internalServerFailure,
      message: e.toString(),
    );
  } else if (e is SomethingWentWrongException) {
    return ServerFailure(
      status: FailureStatus.somethingWentWrong,
      message: e.toString(),
    );
  } else if (e is InternetConnectionException) {
    return ServerFailure(
      status: FailureStatus.networkFailure,
      message: e.toString(),
    );
  } else if (e is SessionTimeoutException) {
    return ServerFailure(
      status: FailureStatus.sendTimeout,
      message: e.toString(),
    );
  } else if (e is NoDataInLocalException) {
    return ServerFailure(
      status: FailureStatus.pageNotFound,
      message: e.toString(),
    );
  } else if (e is ErrorModel) {
    return ServerFailure(
      status: FailureStatus.errorModel,
      message: e.errMsg.toString(),
    );
  } else {
    return ServerFailure(
      status: FailureStatus.somethingWentWrong,
      message: e.toString(),
    );
  }
}

class DioErrorHandler {
  dioException(DioException exception) {
    String? message;
    if (exception.response != null && exception.response!.data is String) {
      message = exception.response!.data;
    }
    switch (exception.response?.statusCode) {
      case 400:
        return ServerFailure(
          status: FailureStatus.badRequest,
          message: message ?? "Please Contact System Support",
        );
      case 401:
        return ServerFailure(
          status: FailureStatus.unauthorized,
          message: message ?? "Please Login",
        );
      case 404:
        return ServerFailure(
          status: FailureStatus.pageNotFound,
          message: message ?? "Please Contact System Support",
        );
      case 405:
        return ServerFailure(
          status: FailureStatus.badResponse,
          message: message ?? "Please Contact System Support",
        );
      case 415:
        return ServerFailure(
          status: FailureStatus.unknown,
          message: message ?? "Please Contact System Support",
        );
      case 700:
        return ServerFailure(
          status: FailureStatus.dataNotFetched,
          message: exception.response?.data ?? "No Data Found",
        );
      case 500:
        return ServerFailure(
          status: FailureStatus.internalServerFailure,
          message: "Internal Server Exception",
        );
      default:
        return ServerFailure(
          status: FailureStatus.somethingWentWrong,
          message: message ?? "Something went wrong",
        );
    }
  }
}

class CommonStateErrorWidget extends StatelessWidget {
  final FailureStatus status;

  const CommonStateErrorWidget({required this.status, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildErrorWidget(status, status.toString());
  }

  Widget _buildErrorWidget(FailureStatus status, String message) {
    switch (status) {
      // case FailureStatus.networkFailure:
      //   return const NoInternetHandlingPage();
      // case FailureStatus.unauthorized:
      //   return const SessionExpireHandlingPage();
      // case FailureStatus.pageNotFound:
      //   return const PageNotFoundHandlingPage();
      case FailureStatus.somethingWentWrong:
        return _textWidget(message);
      case FailureStatus.unknown:
        return _textWidget(message);
      case FailureStatus.dataNotFetched:
        return const Center(child: Text("No Records Found..."));

      default:
        return _textWidget(message);
    }
  }

  Widget _textWidget(String message) {
    return Center(child: Text(message));
  }
}
