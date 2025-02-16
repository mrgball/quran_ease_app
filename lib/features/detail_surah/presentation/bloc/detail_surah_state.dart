part of 'detail_surah_bloc.dart';

class DetailSurahState extends Equatable {
  // STATUS
  final BlocStatus status;

  // DATA
  final Surah detailSurah;
  final SuratNavigation? suratSebelumnya;
  final SuratNavigation? suratSelanjutnya;

  DetailSurahState copyWith({
    BlocStatus? status,
    Surah? detailSurah,
    SuratNavigation? suratSebelumnya,
    SuratNavigation? suratSelanjutnya,
  }) =>
      DetailSurahState(
        status: status ?? this.status,
        detailSurah: detailSurah ?? this.detailSurah,
        suratSebelumnya: suratSebelumnya ?? this.suratSebelumnya,
        suratSelanjutnya: suratSelanjutnya ?? this.suratSelanjutnya,
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
    this.suratSebelumnya,
    this.suratSelanjutnya,
  });

  @override
  List<Object?> get props => [
        status,
        detailSurah,
        suratSebelumnya,
        suratSelanjutnya,
      ];
}
