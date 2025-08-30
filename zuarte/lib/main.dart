// ignore_for_file: use_build_context_synchronously

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/routes/app_routes.dart';
import 'package:zuarte/services/audio_handler.dart';
import 'package:zuarte/services/service_locator.dart';
import 'package:zuarte/theme/app_themes.dart';
import 'package:zuarte/viewmodels/audio_player_provider.dart';
import 'package:zuarte/viewmodels/theme_provider.dart';
import 'services/store_theme_preferences.dart';

SongHandler _songHandler = SongHandler();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //visually check what is being reconstructed
  debugRepaintRainbowEnabled = false;
  _songHandler = await AudioService.init(
    builder: () => SongHandler(),
    config: AudioServiceConfig(
      androidNotificationChannelId: 'com.example.zuarte',
      androidNotificationChannelName: 'Zuarte-Player',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
      androidShowNotificationBadge: true,
      androidNotificationIcon: 'mipmap/ic_notification',
    ),
  );
  setupLocator(_songHandler);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (_) => SongProvider()..loadSongs(_songHandler),
        ),
      ],
      child: MyApp(),
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
          showPerformanceOverlay: false,
          routes: AppRoutes.routes(),
          initialRoute: '/splash_screen',
          //themes
          theme: _lightTheme,
          darkTheme: _darkTheme,
          themeMode: theme.themeMode,
        );
      },
    );
  }
}
