import 'package:equatable/equatable.dart';
import 'package:quran_ease/features/home/data/model/surat_navigation_model.dart';
import 'package:quran_ease/features/home/domain/entity/ayat.dart';
import 'package:quran_ease/features/home/domain/entity/surat_navigation.dart';

class Surah extends Equatable {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jmlAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final Map<String, dynamic> audioFull;
  final List<Ayat> listAyat;

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
