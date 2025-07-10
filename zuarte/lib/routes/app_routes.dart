import 'package:flutter/material.dart';
import 'package:zuarte/screens/app_nav_bar/app_nav_bar.dart';
import 'package:zuarte/screens/home/home.dart';
import 'package:zuarte/screens/splash_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes() {
    return {
      '/splash_screen': (context) => const SplashScreen(),
      '/app_nav_bar': (context) => const AppNavBar(),
      '/home_screen': (context) => const HomeScreen(),
    };
  }
}
