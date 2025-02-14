part of 'home_bloc.dart';

class HomeState extends Equatable {
  // STATUS
  final BlocStatus status;

  // DATAS
  final List<Surah> listSurah;

  const HomeState({
    this.status = BlocStatus.initial,
    this.listSurah = const [],
  });

  HomeState copyWith({
    BlocStatus? status,
    List<Surah>? listSurah,
  }) {
    return HomeState(
      status: status ?? this.status,
      listSurah: listSurah ?? this.listSurah,
    );
  }

  @override
  List<Object?> get props => [
        status,
        listSurah,
      ];
}
