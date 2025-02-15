import 'package:flutter/material.dart';
import 'package:quran_ease/core/shared/screen/splash_screen.dart';
import 'package:quran_ease/features/detail_surah/presentation/screen/detail_surah_screen.dart';
import 'package:quran_ease/features/home/presentation/screen/home_screen.dart';

class MyRouter {
  // DEFINING ROUTES HERE:
  static const String routeHome = '/home';
  static const String routeDetailSurah = '/detail-surah';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    late Widget Function(BuildContext) screenDestination;
    Map<String, dynamic>? arguments;

    if (settings.arguments != null) {
      arguments = settings.arguments as Map<String, dynamic>;
    }

    switch (settings.name) {
      case routeHome:
        screenDestination = (_) => const HomeScreen();
        break;
      case routeDetailSurah:
        screenDestination = (_) => DetailSurahScreen(
              surah: arguments?['surah'],
            );
      default:
        screenDestination = (_) => const SplashScreen();
        break;
    }

    return MyCustomRoute(builder: screenDestination, settings: settings);
  }
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({
    required super.builder,
    required RouteSettings super.settings,
  });

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (settings.arguments != null &&
        (settings.arguments as Map<String, dynamic>)['withAnimation'] == true) {
      // Fades between routes. (If you don't want any animation,
      return FadeTransition(opacity: animation, child: child);
    }
    // just return child.)
    return child;
  }
}
