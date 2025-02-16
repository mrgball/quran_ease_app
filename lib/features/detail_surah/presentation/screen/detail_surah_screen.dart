import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_ease/core/config/enum.dart';
import 'package:quran_ease/core/config/extension.dart';
import 'package:quran_ease/core/config/route.dart';
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
  late int currentSurahId;

  @override
  void didUpdateWidget(covariant DetailSurahScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.surah.nomor != widget.surah.nomor) {
      _detailSurahBloc.add(GetDetailSurahEvent(id: widget.surah.nomor));
    }
  }

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
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),

              // AppBar Transparan
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: const Icon(Icons.arrow_back,
                                color: Colors.white),
                          ),
                          Column(
                            children: [
                              Text(
                                widget.surah.namaLatin,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.surah.nama,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Icon(Icons.more_vert, color: Colors.white),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.arrow_circle_left_outlined,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Surat Sebelumnya',
                                        style: context.text.bodySmall?.copyWith(
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.of(context).pushNamed(
                                    MyRouter.routeDetailSurah,
                                    arguments: {
                                      'surah': widget.surah,
                                    },
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Surat Selanjutnya',
                                        style: context.text.bodySmall?.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(
                                        Icons.arrow_circle_right_outlined,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.dh * 0.02),
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

        final listAyat = state.detailSurah.listAyat;

        return Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(25),
            shrinkWrap: true,
            itemCount: listAyat.length,
            separatorBuilder: (context, index) => Divider(
              thickness: 2,
              color: context.greyBackground,
            ),
            itemBuilder: (context, index) {
              final ayat = listAyat[index];

              return Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: context.primaryShade100,
                      child: Text(
                        '${index + 1}',
                        style: context.text.bodySmall?.copyWith(
                          fontSize: 12,
                          color: context.primary,
                        ),
                      ),
                    ),
                    SizedBox(width: context.dw * 0.2),
                    Flexible(
                      child: Text(
                        ayat.arab,
                        style: context.text.titleLarge?.copyWith(
                          color: context.black,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
