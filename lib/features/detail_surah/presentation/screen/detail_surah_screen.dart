import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quran_ease/core/config/enum.dart';
import 'package:quran_ease/core/config/extension.dart';
import 'package:quran_ease/core/shared/widget/refresher/custom_smart_refresher.dart';
import 'package:quran_ease/core/shared/widget/shimmer_loading.dart';
import 'package:quran_ease/features/detail_surah/presentation/bloc/detail_surah_bloc.dart';
import 'package:quran_ease/features/home/domain/entity/ayat.dart';
import 'package:quran_ease/features/home/domain/entity/surah.dart';
import 'package:quran_ease/features/home/presentation/bloc/home_bloc.dart';

class DetailSurahScreen extends StatefulWidget {
  final Surah surah;
  const DetailSurahScreen({required this.surah, super.key});

  @override
  State<DetailSurahScreen> createState() => _DetailSurahScreenState();
}

class _DetailSurahScreenState extends State<DetailSurahScreen> {
  late final DetailSurahBloc _detailSurahBloc = context.read<DetailSurahBloc>();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final ValueNotifier<String?> _currentlyPlaying = ValueNotifier(null);
  final RefreshController _refreshCont = RefreshController();

  @override
  void didUpdateWidget(covariant DetailSurahScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.surah.nomor != widget.surah.nomor) {
      _onRefresh(false);
    }
  }

  @override
  void initState() {
    super.initState();
    _onRefresh(false);
    _audioPlayer.onPlayerComplete.listen((_) {
      _currentlyPlaying.value == null;
    });

    context.read<HomeBloc>().add(SetLastReadEvent(surah: widget.surah));
  }

  void _onRefresh([bool isRefresh = true]) {
    _detailSurahBloc
        .add(GetDetailSurahEvent(id: widget.surah.nomor, isRefresh: isRefresh));
  }

  void _playAudio(String key, String url) async {
    if (_currentlyPlaying.value == key) {
      await _audioPlayer.stop();
      _currentlyPlaying.value = null;
    } else {
      await _audioPlayer.play(UrlSource(url));
      _currentlyPlaying.value = key;
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  String extractQariName(String url) {
    List<String> parts = url.split("audio-partial/");
    if (parts.length > 1) {
      return parts[1].split("/")[0].replaceAll('-', ' ');
    }
    return "Unknown";
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DetailSurahBloc, DetailSurahState, DetailSurahState>(
      selector: (state) => state,
      builder: (context, state) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: context.dh * 0.15,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          context.primary,
                          context.primaryShade200,
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 10,
                      ),
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    widget.surah.nama,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Icon(Icons.more_vert, color: Colors.white),
                            ],
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              _buildListAyat(state),
            ],
          ),
        );
      },
    );
  }

  void _showModalDetail(Ayat ayat) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (builder) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          padding: const EdgeInsets.all(16),
          height: context.dh * 0.5,
          width: double.infinity,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Terjemahan:',
                  style:
                      context.text.bodyLarge?.copyWith(color: context.greyText),
                ),
                const SizedBox(height: 8),
                Text(
                  ayat.terjemahan,
                  style: context.text.bodyLarge?.copyWith(
                    fontSize: 14,
                    color: context.black,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Audio:',
                  style:
                      context.text.bodyLarge?.copyWith(color: context.greyText),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: ayat.audio.length,
                    itemBuilder: (context, index) {
                      String key = ayat.audio.keys.elementAt(index);
                      String url = ayat.audio[key]!;

                      return ValueListenableBuilder<String?>(
                        valueListenable: _currentlyPlaying,
                        builder: (context, value, child) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(extractQariName(url)),
                            trailing: IconButton(
                              icon: Icon(
                                (value == key) ? Icons.stop : Icons.play_arrow,
                                color: (value == key)
                                    ? Colors.red
                                    : context.primary,
                              ),
                              onPressed: () => _playAudio(key, url),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildListAyat(DetailSurahState state) {
    final listAyat = state.detailSurah.listAyat;

    if (state.status == BlocStatus.loading) {
      return _buildLoading(listAyat.length);
    }

    if (state.status == BlocStatus.error) {
      return const Center(child: Text('Tidak ada data'));
    }

    return Expanded(
      child: CustomSmartRefresher(
        controller: _refreshCont,
        onRefresh: _onRefresh,
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

            return GestureDetector(
              onTap: () {},
              onDoubleTap: () => _showModalDetail(ayat),
              child: Container(
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
                          fontSize: 10,
                          color: context.primary,
                        ),
                      ),
                    ),
                    SizedBox(width: context.dw * 0.2),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            ayat.arab,
                            style: context.text.titleLarge?.copyWith(
                              color: context.black,
                              fontSize: 30,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            ayat.latin,
                            style: context.text.labelSmall?.copyWith(
                              fontSize: 12,
                              color: context.greyText,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoading(int? totalItem) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        shrinkWrap: true,
        itemCount: totalItem == 0 || totalItem == null ? 5 : totalItem,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return ShimmerWidget.rounded(
            width: double.infinity,
            height: context.dp(125),
            borderRadius: BorderRadius.circular(12),
          );
        },
      ),
    );
  }
}
