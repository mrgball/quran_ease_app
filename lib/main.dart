import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quran_ease/core/config/global.dart';
import 'package:quran_ease/core/config/route.dart';
import 'package:quran_ease/core/shared/screen/splash_screen.dart';
import 'package:quran_ease/core/utils/injector.dart';
import 'package:quran_ease/features/detail_surah/presentation/bloc/detail_surah_bloc.dart';
import 'package:quran_ease/features/home/presentation/bloc/home_bloc.dart';
import 'package:requests_inspector/requests_inspector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  initInjector();

  runApp(const RequestsInspector(
    enabled: kDebugMode,
    showInspectorOn: ShowInspectorOn.Both,
    navigatorKey: null,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    gNavigatorKey = _navigatorKey;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => DetailSurahBloc()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: MyRouter.generateRoute,
        home: SplashScreen(),
      ),
    );
  }
}
