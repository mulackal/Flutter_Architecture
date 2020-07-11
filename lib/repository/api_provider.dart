import 'dart:convert';

import 'package:beautysquare/model/passes_responds.dart';
import 'package:beautysquare/samples/dio_error_util.dart';
import 'package:beautysquare/util/logger_util.dart';
import 'package:dio/dio.dart';
import 'package:beautysquare/model/login_responds.dart';
import 'package:beautysquare/util/logging_interceptor.dart';

import 'app_repository.dart';


class ApiProvider implements AppRepository {
  final String base_url = "http://159.65.151.120/i-abide/web/api";
  Dio _dio;

  var client;

  ApiProvider() {
    BaseOptions options =
        BaseOptions(receiveTimeout: 10000, connectTimeout: 10000);
    _dio = Dio(options);
    _dio.interceptors.add(LoggingInterceptor());

  }

  @override
  Future<LoginResponds> loginChecking(FormData datas) async {
    try {

      Response response = await _dio.post(base_url + "/auth/login", data: datas);

     /* options: Options(headers: {
        "Authorization": token,
        "Accept": "application/json"
        "Content-Type": "application/json"
        "Content-Type": "application/x-www-form-urlencoded"
        "Content-Type": "multipart/form-data"
      }));*/


      final statusCode = response.statusCode;
      final Map responseBody = json.decode(response.data);
      final LoginResponds _datas = new LoginResponds.fromJson(responseBody);

      LoggerUtil().d("LoginResponds", _datas.message);

      return _datas;

    } catch (error, stacktrace) {
      LoggerUtil().e("logincall stackTrace:", error);
      print("Exception occured: $error stackTrace: $stacktrace");
      return LoginResponds.withError(DioErrorUtil.handleError(error));
    }
  }

  @override
  Future<PassResponds> getPassesList(FormData datas) async {
    try {

      Response response = await _dio.post(base_url + "/trip/get-list", data: datas);

      final Map responseBody = json.decode(response.data);
      final PassResponds _datas = new PassResponds.fromJson(responseBody);

      LoggerUtil().d("PassResponds", _datas.message);

      return _datas;

    } catch (error, stacktrace) {
      LoggerUtil().e("PassResponds stackTrace:", error);
      print("Exception occured: $error stackTrace: $stacktrace");
      return PassResponds.withError(DioErrorUtil.handleError(error));
    }
  }


}
