part of 'home_bloc.dart';

class HomeState extends Equatable {
  // STATUS
  final BlocStatus status;

  // DATAS
  final List<Surah> listSurah;
  final Surah lastReadSurah;

  const HomeState({
    this.status = BlocStatus.initial,
    this.listSurah = const [],
    this.lastReadSurah = const Surah(
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

  HomeState copyWith({
    BlocStatus? status,
    List<Surah>? listSurah,
    Surah? lastReadSurah,
  }) {
    return HomeState(
      status: status ?? this.status,
      listSurah: listSurah ?? this.listSurah,
      lastReadSurah: lastReadSurah ?? this.lastReadSurah,
    );
  }

  @override
  List<Object?> get props => [
        status,
        listSurah,
        lastReadSurah,
      ];
}
