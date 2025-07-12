import 'package:flutter/material.dart';
import 'package:zuarte/constants/colors.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/utils/style_configs.dart';
import 'package:zuarte/widgets/radio_custom.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = overallHeight();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin()),
      child: Column(
        children: [
          SizedBox(height: height * 0.02),
          Text(
            'Minhas configurações',
            style: textStyle(
              size: 18,
              color: LightColors.primaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
          const RadioCustom(),
        ],
      ),
    );
  }
}
