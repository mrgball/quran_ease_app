import 'package:quran_ease/core/utils/usecase.dart';
import 'package:quran_ease/features/detail_surah/domain/repository/detail_surah_repository.dart';

class GetDetailSurahUsecase
    extends UseCase<Map<String, dynamic>, Map<String, dynamic>> {
  final DetailSurahRepository _detailSurahRepository;

  GetDetailSurahUsecase(this._detailSurahRepository);

  @override
  Future<Map<String, dynamic>> call(Map<String, dynamic>? params) {
    return _detailSurahRepository.fetchDetailSurah(params);
  }
}
