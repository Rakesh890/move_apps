import 'package:dio/dio.dart';

abstract class NetworkInterface{

  Future<Response?> executeGet({required String url});

  Future<Response?> executePost({required String url, required Map<String,dynamic> bodyRequest});
}