import 'package:flutter/material.dart';
import 'package:haytek/theme/color.dart';

class AppTheme {
  final darkblue = Color(0xff292c7c);
  final white = Color(0xfffafafa);
  final gray = Color(0xfff3f3f4);
  final black = Color(0xff212121);
  final blue = Color(0xff14279B);

  AppTheme._();
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Color(0xff2c2772),
    scaffoldBackgroundColor: Color(0xfff5f5f5),
    appBarTheme: AppBarTheme(
      color: Color(0xff2c2772),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
      iconTheme: IconThemeData(
        color: Color(0xfffafafa),
      ),
    ),
    colorScheme: ColorScheme.light(
        primary: Color(0xff2c2772),
        primaryVariant: Colors.white38,
        secondary: Color(0xff212121),
        error: Color(0xFFff5d75)),
    cardTheme: CardTheme(
      color: Colors.teal,
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    textTheme: TextTheme(
      button: TextStyle(
        color: Color(0xff222222),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Color(0xff2c2772),
      iconTheme: IconThemeData(
        color: Color(0xfffafafa),
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.black,
      onPrimary: Colors.black,
      primaryVariant: Colors.black,
      secondary: Colors.red,
    ),
    cardTheme: CardTheme(
      color: Colors.black,
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
  );
}
