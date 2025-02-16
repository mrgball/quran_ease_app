import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quran_ease/core/config/enum.dart';
import 'package:quran_ease/core/utils/injector.dart';
import 'package:quran_ease/features/detail_surah/domain/usecase/detail_surah_usecase.dart';
import 'package:quran_ease/features/home/data/model/surah_model.dart';
import 'package:quran_ease/features/home/data/model/surat_navigation_model.dart';
import 'package:quran_ease/features/home/domain/entity/surat_navigation.dart';

import '../../../home/domain/entity/surah.dart';

part 'detail_surah_event.dart';
part 'detail_surah_state.dart';

class DetailSurahBloc extends Bloc<DetailSurahEvent, DetailSurahState> {
  final Map<String, Surah?> _dataDetailSurah = {};

  DetailSurahBloc() : super(const DetailSurahState()) {
    on<GetDetailSurahEvent>(_onGetDetailSurah);
  }

  void _onGetDetailSurah(
    GetDetailSurahEvent event,
    Emitter emit,
  ) async {
    String keyDetailSurah = event.id.toString();
    try {
      emit(state.copyWith(status: BlocStatus.loading));

      if (_dataDetailSurah.containsKey(keyDetailSurah)) {
        emit(state.copyWith(
          status: BlocStatus.success,
          detailSurah: _dataDetailSurah[keyDetailSurah],
        ));
        return;
      }

      final response = await locator<GetDetailSurahUsecase>().call({
        'id': event.id,
      });

      if (response.isEmpty) throw 'data detail tidak ditemukan';

      if (!_dataDetailSurah.containsKey(keyDetailSurah)) {
        _dataDetailSurah[keyDetailSurah] = null;
      }

      Surah detailSurah = SurahModel.fromJson(response['data']);

      SuratNavigation? suratSebelumnya = (response['data']['suratSebelumnya'] ==
              false)
          ? null
          : SuratNavigationModel.fromJson(response['data']['suratSebelumnya']);

      SuratNavigation? suratSelanjutnya = (response['data']
                  ['suratSelanjutnya'] ==
              false)
          ? null
          : SuratNavigationModel.fromJson(response['data']['suratSelanjutnya']);

      emit(state.copyWith(
        status: BlocStatus.success,
        detailSurah: detailSurah,
        suratSebelumnya: suratSebelumnya,
        suratSelanjutnya: suratSelanjutnya,
      ));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.error));
    }
  }
}
