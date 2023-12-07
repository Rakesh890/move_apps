import 'package:dio/src/response.dart';

abstract class AppException {}

class FetchDataException extends AppException {}

class BadRequestException extends AppException {
  BadRequestException(List<Response?> list);
}

class UnauthorisedException extends AppException {}

class InvalidInputException extends AppException {}

class GeneralException extends AppException {}

class InternalServerError extends AppException {}

class SocketException extends AppException {}

class ForbiddenException extends AppException{}

class FormatException extends AppException{}

