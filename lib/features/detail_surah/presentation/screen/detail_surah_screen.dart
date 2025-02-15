import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran_ease/core/config/enum.dart';
import 'package:quran_ease/core/config/extension.dart';
import 'package:quran_ease/features/detail_surah/presentation/bloc/detail_surah_bloc.dart';
import 'package:quran_ease/features/home/domain/entity/surah.dart';

class DetailSurahScreen extends StatefulWidget {
  final Surah surah;
  const DetailSurahScreen({required this.surah, super.key});

  @override
  State<DetailSurahScreen> createState() => _DetailSurahScreenState();
}

class _DetailSurahScreenState extends State<DetailSurahScreen> {
  late final DetailSurahBloc _detailSurahBloc = context.read<DetailSurahBloc>();

  @override
  void initState() {
    super.initState();
    _detailSurahBloc.add(GetDetailSurahEvent(id: widget.surah.nomor));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: context.dh * 0.20,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      context.primary,
                      context.primaryShade100,
                    ], // Warna gradient hijau
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),

              // AppBar Transparan
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child:
                            const Icon(Icons.arrow_back, color: Colors.white),
                      ), // Icon Back
                      Text(
                        widget.surah.nama,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(Icons.more_vert, color: Colors.white),
                    ],
                  ),
                ),
              ),

              // Tulisan di tengah header
              Positioned(
                top: 200,
                left: 0,
                right: 0,
                child: Center(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/bismillah.svg',
                        width: 500,
                        height: 500,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.dh * 0.04),
          _buildListAyat(),
        ],
      ),
    );
  }

  Widget _buildListAyat() {
    return BlocSelector<DetailSurahBloc, DetailSurahState, DetailSurahState>(
      selector: (state) => state,
      builder: (context, state) {
        if (state.status == BlocStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == BlocStatus.error) {
          return const Center(child: Text('tidak ada data'));
        }

        /// TODO: DISPLAYING AYAT
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text('ini list ayat'),
          ),
        );
      },
    );
  }
}
