import 'dart:async';
import 'dart:core';
import 'package:dio/dio.dart';
import 'package:movie_app/core/constants/api_config.dart';
import 'package:movie_app/data/data_sources/newtwork/network_interface/network_interface.dart';
import 'interceptor/logging_interceptor.dart';

class ApiProvider extends NetworkInterface {
  final _client = Dio();
  Map<String, String> _requestHeader = {};

  ApiProvider() {
    _client.options.queryParameters = {'api_key': ApiConfig.apiKey};
    _client.interceptors.addAll([
      LoggingInterceptor(),
    ]);
  }

  Future<Map<String, String>> headersInitialize() async {
    final Map<String, String> headers = {};
    headers.addAll({
      "Accept": "*/*",
      "Connection": "keep-alive",
      "Content-type": 'application/json',

    });
    headers.addAll({
      'accept': 'application/json',
      'Authorization': ApiConfig.accessToken
    });

    return headers;
  }

  @override
  Future<Response?> executeGet({required String url}) async {
    _requestHeader = await headersInitialize();
    final response =
        await _client.get(url, options: Options(headers: _requestHeader));
    return response;
  }

  @override
  Future<Response?> executePost(
      {required String url, required Map<String, dynamic> bodyRequest}) async {
    _requestHeader = await headersInitialize();
    final response = await _client.post(url,
        options: Options(headers: _requestHeader), data: bodyRequest);
    return response;
  }
}
