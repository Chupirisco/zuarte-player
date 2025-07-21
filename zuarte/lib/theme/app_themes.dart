import 'package:flutter/material.dart';
import 'package:zuarte/constants/colors.dart';

class AppThemes {
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Montserrat',
      scaffoldBackgroundColor: LightColors.background,
      useMaterial3: true,
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'Montserrat',
      scaffoldBackgroundColor: DarkColors.background,
      //  textTheme: TextTheme(),
      useMaterial3: true,
      //  listTileTheme: ListTileThemeData(),
    );
  }
}
