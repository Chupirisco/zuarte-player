import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/routes/app_routes.dart';
import 'package:zuarte/themes/app_themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return LayoutBuilder(
      builder: (context, constraints) {
        Device.setScreenSize(
          context,
          constraints,
          MediaQuery.of(context).orientation,
          constraints.maxWidth,
          constraints.maxWidth,
        );
        return MaterialApp(
          title: "Zuarte-Player",
          debugShowCheckedModeBanner: false,
          showPerformanceOverlay: false,
          routes: AppRoutes.routes(),
          initialRoute: "/splash_screen",
          theme: AppThemes.lightTheme,
        );
      },
    );
  }
}
