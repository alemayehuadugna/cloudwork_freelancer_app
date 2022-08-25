import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import 'error/exceptions.dart';
import 'utils/constants.dart';

class DioConfig {
  static Future<Dio> init() async {
    Dio dio = Dio(BaseOptions(baseUrl: apiBaseUrl));

    // add interceptor to dio
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      // get user token
      final isBoxOpen = Hive.isBoxOpen('token');
      final tokenBox =
          isBoxOpen ? Hive.box('token') : await Hive.openBox('token');
      final token = await tokenBox.get(cachedTokenKey);
      if (token != Null) {
        options.headers['authorization'] = "Bearer $token";
      }
      debugPrint("request url: ${options.path}");
      return handler.next(options);
    }, onResponse: (response, handler) {
      if (response.statusCode! >= 200 || response.statusCode! < 300) {
        return handler.next(response);
      } else {
        response = ServerException() as Response;
        return handler.next(response);
      }
    }, onError: (DioError e, handler) {
      // ignore: avoid_print
      print(e);
      return handler.next(e);
    }));
    return dio;
  }
}
