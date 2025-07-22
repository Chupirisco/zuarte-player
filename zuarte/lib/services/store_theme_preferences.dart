import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreThemePreferences {
  ThemeMode? _savedTheme;

  ThemeMode get savedTheme => _savedTheme!;

  Future<void> loadTheme() async {
    final storage = await SharedPreferences.getInstance();
    final String? storedTheme = storage.getString('storedTheme');

    switch (storedTheme) {
      case 'dark':
        _savedTheme = ThemeMode.dark;
        break;

      case 'light':
        _savedTheme = ThemeMode.light;
        break;

      case 'system':
        _savedTheme = ThemeMode.system;
        break;

      case null:
        return await startStorage();
    }
  }

  Future<void> saveTheme(String selectedTheme) async {
    final storage = await SharedPreferences.getInstance();
    await storage.setString('storedTheme', selectedTheme);

    switch (selectedTheme) {
      case 'dark':
        _savedTheme = ThemeMode.dark;
        break;

      case 'light':
        _savedTheme = ThemeMode.light;
        break;

      case 'system':
        _savedTheme = ThemeMode.system;
        break;
    }
  }

  Future<void> startStorage() async {
    final storage = await SharedPreferences.getInstance();
    await storage.setString('storedTheme', 'system');

    return await loadTheme();
  }
}
