import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeMode themeMode;

  ThemeProvider({required this.themeMode});

  void loadTheme(ThemeMode themeMode) {
    themeMode = themeMode;
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
