import 'package:flutter/material.dart';

class AppTheme {
  static const double smallFontSize = 16;
  static const double normalFontSize = 22;
  static const double largeFontSize = 24;

  static const normalTextColors = Colors.black;
  static const darkTextColors = Colors.lightGreen;

  static final ThemeData normalTheme = ThemeData(
    primarySwatch: Colors.purple,
    canvasColor: const Color(0xFFFEFEFE),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontSize: normalFontSize,
        color: normalTextColors,
      ),
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontSize: normalFontSize,
        color: normalTextColors,
      ),
    ),
  );
}
