import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran_ease/core/config/extension.dart';
import 'package:quran_ease/features/home/presentation/bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeBloc _homeBloc = context.read<HomeBloc>();

  @override
  void initState() {
    super.initState();
    _homeBloc.add(const GetSurahEvent());
  }

  @override
  Widget build(BuildContext context) {
    print(_homeBloc.state.listSurah.length);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              _buildHeader(),
              SizedBox(height: context.dh * 0.05),
              _buildCard()
            ],
          ),
        ),
      ),
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
      height: context.dh * 0.2,
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
