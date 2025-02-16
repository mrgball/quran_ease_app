import 'package:equatable/equatable.dart';

class SuratNavigation extends Equatable {
  final int nomor;
  final String nama;
  final String latin;
  final int jumlahAyat;

  const SuratNavigation({
    required this.nomor,
    required this.nama,
    required this.latin,
    required this.jumlahAyat,
  });

  @override
  List<Object?> get props => [
        nomor,
        nama,
        latin,
        jumlahAyat,
      ];
}
