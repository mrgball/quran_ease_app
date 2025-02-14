import 'package:equatable/equatable.dart';

class Surah extends Equatable {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jmlAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final Map<String, String> audioFull;

  const Surah({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jmlAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audioFull,
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
