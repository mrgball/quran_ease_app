import 'package:equatable/equatable.dart';

class Surah extends Equatable {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jmlAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final Map<String, dynamic> audioFull;
  final List<Ayat>? listAyat;
  final Map<String, Surah>? surahSebelumnya;
  final Map<String, Surah>? surahSelanjutnya;

  const Surah({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jmlAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audioFull,
    this.listAyat = const [],
    this.surahSebelumnya = const {},
    this.surahSelanjutnya = const {},
  });

  @override
  List<Object?> get props => [
        nomor,
        nama,
        namaLatin,
        jmlAyat,
        tempatTurun,
        arti,
        deskripsi,
        audioFull,
      ];
}

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
