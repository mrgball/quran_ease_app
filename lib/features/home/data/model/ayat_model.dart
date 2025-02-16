import 'package:quran_ease/features/home/domain/entity/ayat.dart';

class AyatModel extends Ayat {
  const AyatModel({
    required super.nomorAyat,
    required super.arab,
    required super.latin,
    required super.terjemahan,
    required super.audio,
  });

  factory AyatModel.fromJson(Map<String, dynamic> json) => AyatModel(
        nomorAyat: json['nomorAyat'] ?? 0,
        arab: json['teksArab'] ?? '',
        latin: json['teksLatin'] ?? '',
        terjemahan: json['teksIndonesia'] ?? '',
        audio: json['audio'] ?? {},
      );

  @override
  List<Object?> get props => [
        nomorAyat,
        arab,
        latin,
        terjemahan,
        audio,
      ];
}
