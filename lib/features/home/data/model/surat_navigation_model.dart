import 'package:quran_ease/features/home/domain/entity/surat_navigation.dart';

class SuratNavigationModel extends SuratNavigation {
  const SuratNavigationModel({
    required super.nomor,
    required super.nama,
    required super.latin,
    required super.jumlahAyat,
  });

  factory SuratNavigationModel.fromJson(Map<String, dynamic> json) =>
      SuratNavigationModel(
        nomor: json['nomor'] ?? 0,
        nama: json['nama'] ?? '',
        latin: json['namaLatin'] ?? '',
        jumlahAyat: json['jumlahAyat'] ?? 0,
      );

  @override
  List<Object?> get props => [
        nomor,
        nama,
        latin,
        jumlahAyat,
      ];
}
