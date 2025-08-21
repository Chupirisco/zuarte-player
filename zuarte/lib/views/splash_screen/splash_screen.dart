// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:zuarte/utils/style_configs.dart';
import 'package:zuarte/viewmodels/audio_player_provider.dart';
import '../../constants/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  bool showLoading = false;
  bool allowed = false;

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  Future<void> checkPermission() async {
    bool permission = await _audioQuery.permissionsStatus();
    if (permission) {
      setState(() {
        allowed = permission;
      });
      await handlePermissionFlow();
    } else {
      setState(() {
        showLoading = false;
      });
    }
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
            showLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      bool permission = await _audioQuery.permissionsStatus();
                      if (!permission) {
                        permission = await _audioQuery.permissionsRequest();
                      }

                      if (permission) {
                        allowed = permission;
                      }
                      await handlePermissionFlow();
                    },
                    child: Text('aperte aqui'),
                  ),
            SizedBox(height: height * 0.05),
            Text('by YR', style: textStyle(size: 13, color: theme.secondary)),
            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }

  Future<void> handlePermissionFlow() async {
    setState(() {
      showLoading = true;
    });

    if (allowed) {
      context.read<AudioPlayerProvider>().initListSongs();
    }

    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil('/app_nav_bar', (_) => false);
  }
}
