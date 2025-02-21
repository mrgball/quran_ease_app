import 'package:flutter/material.dart';

// Mockup design size
const mockupHeight = 852;
const mockupWidth = 393;

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String toTitleCase() {
    if (isEmpty) return this;

    return split(' ')
        .map((word) => word.isNotEmpty ? word.capitalize() : word)
        .join(' ');
  }
}

extension DoubleEx on double {
  double dp({required double parentWidth}) => this / mockupWidth * parentWidth;

  double h({required double parentHeight}) =>
      this / mockupHeight * parentHeight;
}

extension ScreenUtil on BuildContext {
  TextTheme get text => Theme.of(this).textTheme;

  // Device info
  double get dw => MediaQuery.of(this).size.width;
  double get dh => MediaQuery.of(this).size.height;
  double dp(double size) => size / mockupWidth * dw;

  // Responsive Helper
  bool get isMobile => dw < 600;
  bool get isTablet => dw >= 600;
  bool get isDesktop => dw >= 1100;

  double get sw => mockupWidth / dw;
  double get sh => mockupHeight / dh;

  // Device Orientation
  Orientation get orientation => MediaQuery.of(this).orientation;
  bool get isLandscape => orientation == Orientation.landscape;
  bool get isPortrait => orientation == Orientation.portrait;

  // COLORS THEME
  Color get primary => const Color(0xFF186351);
  Color get primaryShade50 => primaryShades[50]!;
  Color get primaryShade100 => primaryShades[100]!;
  Color get primaryShade200 => primaryShades[200]!;
  Color get primaryShade300 => primaryShades[300]!;
  Color get primaryShade400 => primaryShades[400]!;
  Color get primaryShade500 => primaryShades[500]!;
  Color get primaryShade600 => primaryShades[600]!;
  Color get primaryShade700 => primaryShades[700]!;
  Color get primaryShade800 => primaryShades[800]!;
  Color get primaryShade900 => primaryShades[900]!;

  Color get black => const Color(0xFF111111);
  Color get blackAccent => const Color(0xFF50555C);
  Color get grey => const Color(0xFFE9EBED);
  Color get greyBackground => const Color(0xFFF0F3F6);
  Color get greyText => const Color(0xFFADB3BC);

  // Shades
  static const MaterialColor primaryShades = MaterialColor(
    0xFF186351,
    <int, Color>{
      50: Color(0xFFE3F2F0),
      100: Color(0xFFB8DFDA),
      200: Color(0xFF8BCCC3),
      300: Color(0xFF5EB9AD),
      400: Color(0xFF3CA999),
      500: Color(0xFF186351),
      600: Color(0xFF155947),
      700: Color(0xFF124F3D),
      800: Color(0xFF0F4533),
      900: Color(0xFF0A3424),
    },
  );
}
