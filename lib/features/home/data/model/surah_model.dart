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
    super.listAyat,
    super.surahSebelumnya,
    super.surahSelanjutnya,
  });

  factory SurahModel.fromJson(Map<String, dynamic> json) => SurahModel(
        nomor: json['nomor'] ?? 0,
        nama: json['nama'] ?? '',
        namaLatin: json['namaLatin'] ?? '',
        jmlAyat: json['jumlahAyat'] ?? 0,
        tempatTurun: json['tempatTurun'] ?? '',
        arti: json['arti'] ?? '',
        deskripsi: json['deskripsi'] ?? '',
        audioFull: json['audioFull'] ?? '',
        listAyat: (json['ayat'] == null)
            ? []
            : (json['ayat'] as List)
                .map((item) => AyatModel.fromJson(item))
                .toList(),
        surahSelanjutnya: json['surat_selanjutnya'],
        surahSebelumnya: json['surat_sebelumnya'],
      );
}

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
        arab: json['ar'] ?? '',
        latin: json['tr'] ?? '',
        terjemahan: json['idn'] ?? '',
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
