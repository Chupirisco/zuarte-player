import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:on_audio_query/on_audio_query.dart';
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
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  void initState() {
    super.initState();
    loadTheme();
    pedirPermissao();
  }

  void loadTheme() async {
    final themeStorage = StoreThemePreferences();
    await themeStorage.loadTheme();
    // ignore: use_build_context_synchronously
    context.read<ThemeProvider>().loadTheme(themeStorage.savedTheme);
  }

  Future<void> pedirPermissao() async {
    // Verifica se já tem permissão
    bool permitido = await _audioQuery.permissionsStatus();
    if (!permitido) {
      // Solicita a permissão
      await _audioQuery.permissionsRequest();
    }
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
