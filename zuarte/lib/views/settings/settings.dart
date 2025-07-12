import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:zuarte/constants/colors.dart';
import 'package:zuarte/constants/icons.dart';
import 'package:zuarte/views/settings/settings_styles.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/utils/style_configs.dart';
import 'package:zuarte/widgets/cards.dart';
import 'package:zuarte/views/settings/radio_custom.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = overallHeight();
    final width = overallWidth();
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
          SizedBox(height: height * 0.02),
          //Radio component
          const RadioCustom(),
          SizedBox(height: height * 0.02),
          //other component
          componentCard(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            height: height * 0.11,
            child: Row(
              children: [
                Iconify(AppIcons.github, size: iconSize(23)),
                SizedBox(width: width * 0.02),
                Text(
                  'Contribuir com o projeto',
                  style: textStyle(
                    size: 15,
                    color: LightColors.primaryText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: settingsButtonStyle(),
                  onPressed: () {},
                  child: Text(
                    'Acessar',
                    style: textStyle(
                      size: 15,
                      color: LightColors.primaryAction,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
