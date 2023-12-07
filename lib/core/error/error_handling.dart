import 'package:dio/dio.dart';

import 'app_exception.dart';

errorParser({required Response? result, DioException? error}) {
  switch (result?.statusCode) {
    case 400:
      return BadRequestException([result]);
    case 404:
      return GeneralException();
    case 401:
      return UnauthorisedException();
    case 403:
      return ForbiddenException();
    case 500:
      return InternalServerError();
    default:
      return otherError(error);
  }
}

otherError(DioException? error) {
  if (error?.error.runtimeType.toString() == "SocketException") {
    return SocketException();
  } else if (error?.error.runtimeType.toString() == "FormatException") {
    return FormatException();
  }
  return GeneralException();
}