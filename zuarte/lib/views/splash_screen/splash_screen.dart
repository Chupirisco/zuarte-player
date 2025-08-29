import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'package:zuarte/utils/style_configs.dart';
import 'package:zuarte/viewmodels/audio_player_provider.dart';
import '../../constants/images.dart';
import '../../widgets/custom_circular_progress_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<SongProvider>();

      provider.addListener(() {
        if (!provider.isLoading) {
          if (!mounted) return;
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('/app_nav_bar', (route) => false);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final height = 100.h;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: height * 0.15),
            Image.asset(AppImages.appLogo, height: height * 0.2),
            SizedBox(height: height * 0.02),
            Text(
              'ZUARTE',
              style: textStyle(
                size: 30,
                color: theme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height * 0.08),
            Text(
              'Seu player, sua vibe\nseu flow.',
              textAlign: TextAlign.center,
              style: textStyle(size: 18, color: theme.primary),
            ),
            const Spacer(),

            Consumer<SongProvider>(
              builder: (context, value, child) {
                return value.isLoading
                    ? customCircularProgressIndicator(theme)
                    : const SizedBox.shrink();
              },
            ),

            SizedBox(height: height * 0.05),
            Text('by YR', style: textStyle(size: 13, color: theme.secondary)),
            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }
}
