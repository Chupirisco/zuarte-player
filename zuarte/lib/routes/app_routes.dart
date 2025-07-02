import 'package:flutter/material.dart';
import 'package:zuarte/screens/home.dart';
import 'package:zuarte/screens/splash_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes() {
    return {
      '/splash_screen': (context) => const SplashScreen(),
      '/home_screen': (context) => const HomeScreen(),
    };
  }
}
