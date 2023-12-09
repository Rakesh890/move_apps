import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/app_exception.dart';
import 'package:movie_app/domain/entity/user_info_entity.dart';
import 'package:movie_app/domain/repository/user_repository.dart';

class UserUseCase {
  final UserRepository userRepository;

  UserUseCase({required this.userRepository});

  FutureOr<Either<UserInfoEntity, AppException>> getUserInfo(
      {required String url}) async {
    final result = await userRepository.getUserInfo(url: url);
    return result;
  }
}
