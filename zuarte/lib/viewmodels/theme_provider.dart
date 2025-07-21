import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool? isOn) {
    if (isOn == null) {
      _themeMode = ThemeMode.system;
    } else {
      _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    }
    notifyListeners();
  }
}
