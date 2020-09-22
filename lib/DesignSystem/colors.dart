import 'package:flutter/material.dart';

class Global {
  static const Color white = const Color(0xffffffff);
  static const Color mediumBlue = const Color(0xff4A64FE);
  static const Color blueAccent = const Color(0xffb1cbcd);
  static const List<Color> palette = [mediumBlue, DarwinRed];
  static const double scale = 1;
  static const double radius = 88.0;
  static const double bottomPadding = 75.0;
}

///
/// Solid color system
/// consists of solid colors, without transparency
///
/// used for main solid colors
const DarwinPrimaryDark = const Color(0xff000000);
const DarwinPrimary = const Color(0xff2026d2);
const DarwinAccent = const Color(0xff62e1fc);
const DarwinSecondary = const Color(0xfff34d77);
const DarwinSuccess = const Color(0xff4aa740);
const DarwinSuccessLight = const Color(0xffe6f4e9);
const DarwinWarning = const Color(0xffff8212);
const DarwinWarningLight = const Color(0xffffecdc);
const DarwinInfo = const Color(0xff3eacfc);
const DarwinInfoLight = const Color(0xffe8f0fd);
const DarwinDanger = const Color(0xfff64a4a);
const DarwinDangerLight = const Color(0xfffce8e6);
const DarwinWhite = const Color(0xffffffff);
const DarwinGray = const Color(0xffc2c7cf);
const DarwinBlack = const Color(0xff000000);
const DarwinRed = const Color(0xff0f52BA);
const DarwinLightRed = const Color(0xffF27D7D);
const DarwinDarkRed = const Color(0xFFB71C1C);

///
/// Alpha color system
/// consists of light colors, with transparency
///
/// generally used for shadows
const DarwinPrimaryDarkShadow = const Color.fromRGBO(22, 24, 73, 0.2);
const DarwinWarningShadow = const Color.fromRGBO(255, 130, 18, 0.45);
const DarwinSuccessShadow = const Color.fromRGBO(74, 167, 64, 0.45);
const DarwinDangerShadow = const Color.fromRGBO(246, 74, 74, 0.45);
const DarwinInfoShadow = const Color.fromRGBO(62, 172, 252, 0.45);
