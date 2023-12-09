import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entity/user_info_entity.dart';

import '../../core/error/app_exception.dart';

abstract class UserRepository {
  Future<Either<UserInfoEntity, AppException>> getUserInfo(
      {required String url});
}
