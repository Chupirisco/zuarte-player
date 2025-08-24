import 'package:flutter/material.dart';
import 'package:zuarte/views/app_nav_bar/app_nav_bar.dart';
import 'package:zuarte/views/list_of_songs/list_of_songs_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes() {
    return {
      '/app_nav_bar': (context) => const AppNavBar(),
      '/home_screen': (context) => const ListOfSongs(),
    };
  }
}
