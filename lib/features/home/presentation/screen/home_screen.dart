import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quran_ease/core/config/enum.dart';
import 'package:quran_ease/core/config/extension.dart';
import 'package:quran_ease/core/config/route.dart';
import 'package:quran_ease/core/shared/widget/refresher/custom_smart_refresher.dart';
import 'package:quran_ease/core/shared/widget/shimmer_list_tiles.dart';
import 'package:quran_ease/features/home/domain/entity/surah.dart';
import 'package:quran_ease/features/home/presentation/bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeBloc _homeBloc = context.read<HomeBloc>();
  final RefreshController _refreshCont = RefreshController();

  @override
  void initState() {
    super.initState();
    _onRefresh(false);
  }

  void _onRefresh([bool isRefresh = true]) {
    _homeBloc.add(GetSurahEvent(isRefresh: isRefresh));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              _buildHeader(),
              SizedBox(height: context.dh * 0.05),
              _buildCard(),
              SizedBox(height: context.dh * 0.02),
              BlocSelector<HomeBloc, HomeState, HomeState>(
                selector: (state) => state,
                builder: (context, state) {
                  if (state.status == BlocStatus.loading) {
                    return _buildLoading();
                  }

                  if (state.status == BlocStatus.error ||
                      state.listSurah.isEmpty) {
                    return _buildEmpty();
                  }

                  return _buildListSurah(state);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/empty.png',
            width: context.dw * 0.7,
          ),
          Text('Surat tidak ditemukan',
              style: context.text.bodyLarge
                  ?.copyWith(fontSize: 18, color: context.blackAccent)),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: context.primary,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 32)),
            onPressed: () {},
            child: Text('Muat Ulang',
                style: context.text.labelMedium
                    ?.copyWith(fontSize: 14, color: Colors.white)),
          )
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ShimmerListTiles(
          jumlahItem: 10,
          shrinkWrap: true,
        ),
      ),
    );
  }

  Widget _buildListSurah(HomeState state) {
    return Expanded(
      child: CustomSmartRefresher(
        controller: _refreshCont,
        onRefresh: _onRefresh,
        child: ListView.separated(
          itemCount: state.listSurah.length,
          separatorBuilder: (context, index) => Divider(
            thickness: 1,
            color: context.greyBackground,
          ),
          itemBuilder: (context, index) {
            final surah = state.listSurah[index];

            return GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                MyRouter.routeDetailSurah,
                arguments: {
                  'surah': surah,
                },
              ),
              onLongPress: () => _showModalDetail(surah),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: context.primaryShade100,
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: context.text.labelSmall?.copyWith(
                        color: context.primary,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  '${surah.namaLatin} (${surah.jmlAyat})',
                  style: context.text.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.black,
                  ),
                ),
                subtitle: Text(
                  surah.arti,
                  style: context.text.labelSmall
                      ?.copyWith(color: context.greyText),
                ),
                trailing: Text(
                  surah.nama,
                  style: context.text.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.primary,
                    fontSize: 26,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showModalDetail(Surah surah) {
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
                  'Deskripsi:',
                  style:
                      context.text.bodyLarge?.copyWith(color: context.greyText),
                ),
                const SizedBox(height: 16),
                HtmlWidget(surah.deskripsi),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.sort,
            color: context.greyText,
          ),
        ),
        Text(
          'Quran Ease',
          style: context.text.bodyLarge?.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.search_rounded,
            color: context.greyText,
          ),
        ),
      ],
    );
  }

  Widget _buildCard() {
    return Container(
      padding: const EdgeInsets.all(25),
      height: context.dh * 0.19,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Last Read',
                style: context.text.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'ةحتافلا',
                style: context.text.headlineLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: Text(
                  'Continue',
                  style: context.text.bodySmall?.copyWith(
                    color: context.primary,
                  ),
                ),
              )
            ],
          ),
          SvgPicture.asset(
            'assets/objects.svg',
            height: context.dh * 0.15,
          ),
        ],
      ),
    );
  }
}
