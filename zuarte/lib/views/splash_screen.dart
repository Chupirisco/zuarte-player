// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/utils/style_configs.dart';
import 'package:zuarte/viewmodels/list_songs_provider.dart';

import '../constants/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    loadProviders();

    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil('/app_nav_bar', (route) => false);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  //method responsible for loading the providers
  Future<void> loadProviders() async {
    await context.read<ListSongsProvider>().initListSongs();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;
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
              'Seu player, sua vibe\n seu flow.',
              textAlign: TextAlign.center,
              style: textStyle(size: 18, color: theme.primary),
            ),
            const Spacer(),
            Text(
              'by BRY STUDIO',
              style: textStyle(size: 13, color: theme.secondary),
            ),
            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }
}
