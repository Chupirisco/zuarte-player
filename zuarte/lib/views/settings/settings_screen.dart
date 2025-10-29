// ignore_for_file: use_build_context_synchronously
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../constants/icons.dart';
import '../../utils/size_config.dart';
import '../../utils/style_configs.dart';
import '../../widgets/cards.dart';
import 'radio_custom.dart';
import 'settings_styles.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

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
        ],
      ),
    );
  }

  Future<void> alertDialog(BuildContext ctx, ColorScheme theme) {
    return showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Iconify(AppIcons.alert, color: theme.error, size: iconSize(23)),
              Text(
                'Permissões já concedidas',
                style: textStyle(
                  size: 16,
                  color: theme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          titlePadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        );
      },
    );
  }

  Future<void> showDeniedDialog(BuildContext ctx, ColorScheme theme) {
    return showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Iconify(AppIcons.alert, color: theme.error, size: iconSize(23)),
              SizedBox(width: 10),
              Text(
                'Permissão negada',
                style: textStyle(
                  size: 16,
                  color: theme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            'O Zuarte precisa de acesso às músicas para funcionar corretamente. Abra as configurações do app e habilite o acesso a músicas.',
            style: textStyle(
              size: 14,
              color: theme.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancelar',
                style: textStyle(
                  size: 14,
                  color: theme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                openAppSettings();
                Navigator.of(context).pop();
              },
              child: Text(
                'Abrir configurações',
                style: textStyle(
                  size: 14,
                  color: theme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
