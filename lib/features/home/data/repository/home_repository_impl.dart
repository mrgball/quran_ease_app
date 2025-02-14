import 'package:dio/dio.dart';
import 'package:quran_ease/core/config/global.dart';
import 'package:quran_ease/core/helper/dio_helper.dart';
import 'package:quran_ease/core/utils/app_exceptions.dart';
import 'package:quran_ease/core/utils/injector.dart';
import 'package:quran_ease/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final DioHelper _dioHelper = locator<DioHelper>();

  @override
  Future<List> fetchSurah(Map<String, dynamic>? params) async {
    try {
      final response = await _dioHelper.getRequest(
        '/api/v2/surat',
      );

      if (response.data['code'] != 200) {
        throw DataException(message: response.data['message']);
      }

      return response.data['data'] ?? [];
    } on DioException catch (e) {
      throw DataException(
        message: e.response?.data['message'] ?? gPesanError,
      );
    } catch (e) {
      rethrow;
    }
  }
}
