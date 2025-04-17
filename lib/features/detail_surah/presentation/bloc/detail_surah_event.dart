part of 'detail_surah_bloc.dart';

class DetailSurahEvent extends Equatable {
  const DetailSurahEvent();

  @override
  List<Object> get props => [];
}

class GetDetailSurahEvent extends DetailSurahEvent {
  final int id;
  final bool isRefresh;

  const GetDetailSurahEvent({
    required this.id,
    this.isRefresh = false,
  });

  @override
  List<Object> get props => [id, isRefresh];
}
