import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quran_ease/core/config/enum.dart';
import 'package:quran_ease/core/utils/injector.dart';
import 'package:quran_ease/features/home/data/model/surah_model.dart';
import 'package:quran_ease/features/home/domain/entity/surah.dart';
import 'package:quran_ease/features/home/domain/usecase/home_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<GetSurahEvent>(_onGetSurah);
  }

  void _onGetSurah(
    GetSurahEvent event,
    Emitter emit,
  ) async {
    try {
      emit(state.copyWith(status: BlocStatus.loading));

      final response = await locator<GetSurahUseCase>().call({});

      if (response.isEmpty) throw 'data tidak ditemukan';

      List<Surah> listSurah =
          response.map((item) => SurahModel.fromJson(item)).toList();

      emit(state.copyWith(
        status: BlocStatus.success,
        listSurah: listSurah,
      ));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.error));
    }
  }
}
