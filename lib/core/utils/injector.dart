import 'package:get_it/get_it.dart';
import 'package:quran_ease/core/helper/dio_helper.dart';
import 'package:quran_ease/features/detail_surah/data/repository/detail_surah_repository_impl.dart';
import 'package:quran_ease/features/detail_surah/domain/repository/detail_surah_repository.dart';
import 'package:quran_ease/features/detail_surah/domain/usecase/detail_surah_usecase.dart';
import 'package:quran_ease/features/home/data/repository/home_repository_impl.dart';
import 'package:quran_ease/features/home/domain/repository/home_repository.dart';
import 'package:quran_ease/features/home/domain/usecase/home_usecase.dart';

final GetIt locator = GetIt.instance;

void initInjector() {
  locator.registerSingleton<DioHelper>(DioHelper());

  // REPOSITORY
  locator.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());
  locator.registerLazySingleton<DetailSurahRepository>(
    () => DetailSurahRepositoryImpl(),
  );
  // USECASE
  locator.registerLazySingleton<GetSurahUseCase>(
    () => GetSurahUseCase(locator()),
  );
  locator.registerLazySingleton<GetDetailSurahUsecase>(
    () => GetDetailSurahUsecase(locator()),
  );
}
