import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/routes/app_routes.dart';
import 'package:zuarte/theme/app_themes.dart';
import 'package:zuarte/viewmodels/create_playlist.dart';
import 'package:zuarte/viewmodels/theme_provider.dart';

import 'services/store_theme_preferences.dart';

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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeData _lightTheme = lightTheme;
  final ThemeData _darkTheme = darkTheme;

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  void loadTheme() async {
    final themeStorage = StoreThemePreferences();
    await themeStorage.loadTheme();
    // ignore: use_build_context_synchronously
    context.read<ThemeProvider>().loadTheme(themeStorage.savedTheme);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();

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
          themeMode: theme.themeMode,
        );
      },
    );
  }
}
