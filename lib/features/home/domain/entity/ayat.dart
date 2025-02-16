import 'package:equatable/equatable.dart';

class Ayat extends Equatable {
  final int nomorAyat;
  final String arab;
  final String latin;
  final String terjemahan;
  final Map<String, dynamic> audio;

  const Ayat({
    required this.nomorAyat,
    required this.arab,
    required this.latin,
    required this.terjemahan,
    required this.audio,
  });

  @override
  List<Object?> get props => [
        nomorAyat,
        arab,
        latin,
        terjemahan,
        audio,
      ];
}
