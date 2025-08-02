import 'package:flutter/material.dart';
import 'package:zuarte/constants/colors.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'Montserrat',
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    surface: LightColors.background,
    primary: LightColors.primaryText,
    secondary: LightColors.secondaryText,
    primaryContainer: LightColors.cardElements,
    secondaryContainer: LightColors.details,
    onPrimaryContainer: LightColors.primaryAction,
    onPrimary: LightColors.borders,
  ),
);

ThemeData darkTheme = ThemeData(
  fontFamily: 'Montserrat',
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark,
    surface: DarkColors.background,
    primary: DarkColors.primaryText,
    secondary: DarkColors.secondaryText,
    primaryContainer: DarkColors.cardElements,
    secondaryContainer: DarkColors.details,
    onPrimaryContainer: DarkColors.primaryAction,
    onPrimary: DarkColors.borders,
  ),
);
