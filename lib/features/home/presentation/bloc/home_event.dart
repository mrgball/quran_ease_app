part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class GetSurahEvent extends HomeEvent {
  final bool isRefresh;
  const GetSurahEvent({this.isRefresh = false});

  @override
  List<Object?> get props => [false];
}

class SetLastReadEvent extends HomeEvent {
  final Surah surah;

  const SetLastReadEvent({required this.surah});

  @override
  List<Object?> get props => [surah];
}
