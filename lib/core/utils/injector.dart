import 'package:get_it/get_it.dart';
import 'package:quran_ease/core/helper/dio_helper.dart';
import 'package:quran_ease/features/home/data/repository/home_repository_impl.dart';
import 'package:quran_ease/features/home/domain/repository/home_repository.dart';
import 'package:quran_ease/features/home/domain/usecase/home_usecase.dart';

final GetIt locator = GetIt.instance;

void initInjector() {
  locator.registerSingleton<DioHelper>(DioHelper());

  // REPOSITORY
  locator.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());
  // USECASE
  locator.registerLazySingleton<GetSurahUseCase>(() => GetSurahUseCase(
        locator(),
      ));
}
