import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../config/constant.dart';

class DioHelper {
  BaseOptions get _baseOptions => BaseOptions(
        validateStatus: (code) => (code ?? 0) >= 200,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        headers: {
          // 'x-api-key': dotenv.env['X_API_KEY_PROD'],
          // 'X-API-KEY': dotenv.env['X_API_KEY_PROD'],
        },
      );

  Dio get _dio => Dio(_baseOptions)
    ..interceptors.addAll([
      // RequestsInspectorInterceptor(),
      // DioLoggingInterceptor(),
      // PrettyDioLogger(
      //   compact: kDebugMode,
      //   request: kDebugMode,
      //   requestHeader: kDebugMode,
      //   requestBody: kDebugMode,
      //   responseBody: kDebugMode,
      //   responseHeader: kDebugMode,
      //   error: kDebugMode,
      //   maxWidth: 1000,
      // ),
    ]);

  Future<Response> postRequest(
    String path, {
    Map<String, dynamic>? requestBody,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    try {
      final res = await _dio.post(
        Constant.baseUrlProd + path,
        data: requestBody,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      if ((res.statusCode ?? 0) < 200 && (res.statusCode ?? 0) > 300) {
        throw DioException(requestOptions: res.requestOptions);
      }

      return res;
    } on DioException catch (e) {
      if (kDebugMode) print('$e');
      rethrow;
    }
  }

  Future<Response> getRequest(
    String path, {
    Map<String, dynamic>? requestBody,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    try {
      final res = await _dio.get(
        Constant.baseUrlProd + path,
        data: requestBody,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      if ((res.statusCode ?? 0) < 200 && (res.statusCode ?? 0) > 300) {
        throw DioException(requestOptions: res.requestOptions);
      }

      return res;
    } on DioException catch (e) {
      if (kDebugMode) print('$e');
      rethrow;
    }
  }

  Future<Response> patchRequest(
    String path, {
    Map<String, dynamic>? requestBody,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    try {
      final res = await _dio.patch(
        Constant.baseUrlProd + path,
        data: requestBody,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      if ((res.statusCode ?? 0) < 200 && (res.statusCode ?? 0) > 300) {
        throw DioException(requestOptions: res.requestOptions);
      }

      return res;
    } on DioException catch (e) {
      if (kDebugMode) print('$e');
      rethrow;
    }
  }
}
