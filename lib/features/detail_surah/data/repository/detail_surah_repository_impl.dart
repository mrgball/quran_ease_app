import 'package:dio/dio.dart';
import 'package:quran_ease/core/helper/dio_helper.dart';
import 'package:quran_ease/core/utils/app_exceptions.dart';
import 'package:quran_ease/core/utils/injector.dart';
import 'package:quran_ease/features/detail_surah/domain/repository/detail_surah_repository.dart';

class DetailSurahRepositoryImpl extends DetailSurahRepository {
  final DioHelper _dioHelper = locator<DioHelper>();

  @override
  Future<Map<String, dynamic>> fetchDetailSurah(
    Map<String, dynamic>? params,
  ) async {
    try {
      final response = await _dioHelper.getRequest(
        '/surat/${params?['id'] ?? 0}',
      );

      if (response.data['code'] != 200) {
        throw DataException(message: response.data['message']);
      }

      return response.data['data'] ?? [];
    } on DioException catch (e) {
      throw DataException(message: e.response?.data['meta']['message']);
    } catch (e) {
      rethrow;
    }
  }
}
