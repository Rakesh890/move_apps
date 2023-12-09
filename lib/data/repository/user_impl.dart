import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/core/error/app_exception.dart';
import 'package:movie_app/data/data_sources/newtwork/api_service.dart';
import 'package:movie_app/data/models/user_info.dart';
import 'package:movie_app/domain/entity/user_info_entity.dart';
import 'package:movie_app/domain/repository/user_repository.dart';

import '../../core/error/error_handling.dart';

class UserImpl extends UserRepository {
  final ApiProvider apiProvider;

  UserImpl({required this.apiProvider});

  @override
  Future<Either<UserInfoEntity, AppException>> getUserInfo(
      {required String url}) async {
    try {
      final data = await apiProvider.executeGet(url: url);
      if (data?.statusCode == 200) {
        return left(UserInfoModel.fromJson(data!.data));
      } else {
        return right(errorParser(result: data!.data));
      }
    } on DioException catch (error) {
      return right(errorParser(result: error.response, error: error));
    } on SocketException catch (e) {
      return right(SocketException());
    } catch (err) {
      return right(GeneralException());
    }
  }
}
