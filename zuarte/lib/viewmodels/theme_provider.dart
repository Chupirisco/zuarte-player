import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode? themeMode;

  void loadTheme(ThemeMode themeMode) {
    this.themeMode = themeMode;
    notifyListeners();
  }

  void toggleTheme(bool? isOn) {
    if (isOn == null) {
      themeMode = ThemeMode.system;
    } else {
      themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    }
    notifyListeners();
  }
}
