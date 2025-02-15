part of 'detail_surah_bloc.dart';

class DetailSurahState extends Equatable {
  // STATUS
  final BlocStatus status;

  // DATA
  final Surah detailSurah;

  DetailSurahState copyWith({
    BlocStatus? status,
    Surah? detailSurah,
  }) =>
      DetailSurahState(
        status: status ?? this.status,
        detailSurah: detailSurah ?? this.detailSurah,
      );

  const DetailSurahState({
    this.status = BlocStatus.initial,
    this.detailSurah = const Surah(
      nomor: 0,
      nama: '',
      namaLatin: '',
      jmlAyat: 0,
      tempatTurun: '',
      arti: '',
      deskripsi: '',
      audioFull: {},
    ),
  });

  @override
  List<Object> get props => [status, detailSurah];
}
