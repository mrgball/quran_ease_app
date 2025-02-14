import 'package:dio/dio.dart';
import 'package:quran_ease/core/config/global.dart';
import 'package:quran_ease/core/utils/app_exceptions.dart';

class DioExceptionHandler {
  static final DioExceptionHandler _instance = DioExceptionHandler._internal();

  factory DioExceptionHandler() => _instance;

  DioExceptionHandler._internal();

  /// [errorFromDio] digunakan untuk menghandle error dari Dio Exception
  static DataException errorFromDio(DioException e) {
    final err = e.response?.data;
    return DataException(
      message: (err is Map<String, dynamic>)
          ? (err['meta']?['message'] ?? err['message'] ?? gPesanError)
          : err ?? gPesanError,
    );
  }

  /// [errorFromResponse] digunakan untuk menghandle error dari Dio Response
  static DataException errorFromResponse(Response res) {
    return DataException(
      message:
          res.data['meta']?['message'] ?? res.data['message'] ?? gPesanError,
    );
  }
}
