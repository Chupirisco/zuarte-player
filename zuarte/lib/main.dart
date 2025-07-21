import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/routes/app_routes.dart';
import 'package:zuarte/theme/app_themes.dart';
import 'package:zuarte/viewmodels/create_playlist.dart';
import 'package:zuarte/viewmodels/theme_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //visually check what is being reconstructed
  debugRepaintRainbowEnabled = false;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CreatePlaylist()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemeData _lightTheme = AppThemes.lightTheme();
  final ThemeData _darkTheme = AppThemes.darkTheme();
  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeProvider>().themeMode;

    return LayoutBuilder(
      builder: (context, constraints) {
        final orientation = constraints.maxWidth > constraints.maxHeight
            ? Orientation.landscape
            : Orientation.portrait;

        Device.setScreenSize(
          context,
          constraints,
          orientation,
          constraints.maxWidth,
          constraints.maxHeight,
        );

        return MaterialApp(
          title: "Zuarte-Player",
          //disable banner
          debugShowCheckedModeBanner: false,
          //show performace graph
          showPerformanceOverlay: true,
          routes: AppRoutes.routes(),
          initialRoute: "/splash_screen",
          //themes
          theme: _lightTheme,
          darkTheme: _darkTheme,
          themeMode: themeMode,
        );
      },
    );
  }
}
