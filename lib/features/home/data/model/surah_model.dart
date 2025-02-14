import 'package:quran_ease/features/home/domain/entity/surah.dart';

class SurahModel extends Surah {
  const SurahModel({
    required super.nomor,
    required super.nama,
    required super.namaLatin,
    required super.jmlAyat,
    required super.tempatTurun,
    required super.arti,
    required super.deskripsi,
    required super.audioFull,
  });

  factory SurahModel.fromJson(Map<String, dynamic> json) {
    return SurahModel(
      nomor: json['nomor'] ?? 0,
      nama: json['nama'] ?? '',
      namaLatin: json['namaLatin'] ?? '',
      jmlAyat: json['jumlahAyat'] ?? 0,
      tempatTurun: json['tempatTurun'] ?? '',
      arti: json['arti'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      audioFull: json['audioFull'] ?? '',
    );
  }
}
