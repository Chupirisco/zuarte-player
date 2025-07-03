// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zuarte/constants/colors.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/utils/text_style_config.dart';

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
    Future.delayed(const Duration(milliseconds: 5000), () {
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil('/app_nav_bar', (route) => false);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = overallHeight();
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
                color: LightColors.primaryText,
                fontWight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height * 0.08),
            Text(
              'Seu player, sua vibe\n seu flow.',
              textAlign: TextAlign.center,
              style: textStyle(size: 18, color: LightColors.primaryText),
            ),
            const Spacer(),
            Text(
              'by BRY STUDIO',
              style: textStyle(size: 13, color: LightColors.secondaryText),
            ),
            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }
}
