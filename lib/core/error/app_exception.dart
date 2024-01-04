abstract class AppException{}

class GeneralException extends AppException{

  String? message;

  GeneralException({this.message});

}

class FormatException  extends AppException{}

