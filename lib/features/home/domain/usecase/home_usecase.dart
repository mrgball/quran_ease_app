import 'package:quran_ease/core/utils/usecase.dart';
import 'package:quran_ease/features/home/domain/repository/home_repository.dart';

class GetSurahUseCase extends UseCase<List<dynamic>, Map<String, dynamic>> {
  final HomeRepository _homeRepository;

  GetSurahUseCase(this._homeRepository);

  @override
  Future<List<dynamic>> call(Map<String, dynamic> params) {
    return _homeRepository.fetchSurah(params);
  }
}
