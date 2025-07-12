import 'package:flutter/material.dart';
import 'package:zuarte/views/app_nav_bar/app_nav_bar.dart';
import 'package:zuarte/views/home/home.dart';
import 'package:zuarte/views/splash_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes() {
    return {
      '/splash_screen': (context) => const SplashScreen(),
      '/app_nav_bar': (context) => const AppNavBar(),
      '/home_screen': (context) => const HomeScreen(),
    };
  }
}
