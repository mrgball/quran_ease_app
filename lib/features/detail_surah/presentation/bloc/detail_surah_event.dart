part of 'detail_surah_bloc.dart';

class DetailSurahEvent extends Equatable {
  const DetailSurahEvent();

  @override
  List<Object> get props => [];
}

class GetDetailSurahEvent extends DetailSurahEvent {
  final int id;
  const GetDetailSurahEvent({required this.id});

  @override
  List<Object> get props => [id];
}
