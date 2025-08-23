import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sizer/sizer.dart';

import '../../constants/icons.dart';
import '../../utils/size_config.dart';
import '../../utils/style_configs.dart';
import '../../widgets/cards.dart';
import 'radio_custom.dart';
import 'settings_styles.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;
    final height = 100.h;
    final width = 100.w;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin()),
      child: Column(
        children: [
          SizedBox(height: height * 0.02),
          Text(
            'Minhas configurações',
            style: textStyle(
              size: 18,
              color: theme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: height * 0.02),
          //Radio component
          const RadioCustom(),
          SizedBox(height: height * 0.02),
          //other component
          componentCard(
            ctx: context,
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            height: height * 0.11,
            child: Row(
              children: [
                Iconify(
                  AppIcons.github,
                  size: iconSize(23),
                  color: iconColor(theme),
                ),
                SizedBox(width: width * 0.02),
                Text(
                  'Contribuir com o projeto',
                  style: textStyle(
                    size: 15,
                    color: theme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: settingsButtonStyle(context),
                  onPressed: () {},
                  child: Text(
                    'Acessar',
                    style: textStyle(
                      size: 15,
                      color: theme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.02),
          componentCard(
            ctx: context,
            height: height * 0.11,
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Row(
              children: [
                Iconify(
                  AppIcons.padlock,
                  color: iconColor(theme),
                  size: iconSize(23),
                ),
                SizedBox(width: width * 0.02),
                Text(
                  'Alterar permissão',
                  style: textStyle(
                    size: 15,
                    color: theme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: settingsButtonStyle(context),
                  onPressed: () async {
                    final OnAudioQuery audioQuery = OnAudioQuery();
                    bool permission = await audioQuery.permissionsStatus();
                    if (!permission) {
                      permission = await audioQuery.permissionsRequest();
                    } else {
                      // ignore: use_build_context_synchronously
                      alertDialog(context, theme);
                    }
                  },
                  child: Text(
                    'Alternar',
                    style: textStyle(
                      size: 15,
                      color: theme.onPrimaryContainer,
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

  Future<void> alertDialog(BuildContext ctx, ColorScheme theme) {
    return showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          icon: Iconify(AppIcons.alert),
          title: Text(
            'Permissões já concedidas',
            style: textStyle(
              size: 15,
              color: theme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          titlePadding: EdgeInsets.only(bottom: 10.h, left: 10.w, right: 10.w),
        );
      },
    );
  }
}
