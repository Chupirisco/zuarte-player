import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/viewmodels/theme_provider.dart';

import '../../constants/colors.dart';
import '../../constants/icons.dart';
import '../../services/store_theme_preferences.dart';
import '../../widgets/cards.dart';
import 'settings_styles.dart';
import '../../utils/size_config.dart';
import '../../utils/style_configs.dart';

class RadioCustom extends StatefulWidget {
  const RadioCustom({super.key});

  @override
  State<RadioCustom> createState() => _RadioCustomState();
}

enum AppTheme { system, light, dark }

class _RadioCustomState extends State<RadioCustom> {
  final width = 100.w;
  final height = 100.h;
  late AppTheme themeSelected;
  @override
  void initState() {
    super.initState();
    final themeProvider = context.read<ThemeProvider>();
    themeSelected = themeProvider.themeMode == ThemeMode.system
        ? AppTheme.system
        : themeProvider.themeMode == ThemeMode.dark
        ? AppTheme.dark
        : AppTheme.light;
  }

  @override
  Widget build(BuildContext context) {
    final providerTheme = Provider.of<ThemeProvider>(context);
    verification(valueTheme) async {
      final themeStorage = StoreThemePreferences();

      themeSelected = valueTheme;

      switch (valueTheme) {
        case AppTheme.system:
          {
            providerTheme.toggleTheme(null);
            await themeStorage.saveTheme('system');
          }
        case AppTheme.dark:
          {
            providerTheme.toggleTheme(true);
            await themeStorage.saveTheme('dark');
          }
        case AppTheme.light:
          {
            providerTheme.toggleTheme(false);
            await themeStorage.saveTheme('light');
          }
      }
    }

    return componentCard(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      height: height * 0.11,
      child: Row(
        children: [
          Iconify(AppIcons.alterTheme, size: iconSize(23)),
          SizedBox(width: width * 0.02),
          Text(
            'Tema',
            style: textStyle(
              size: 16,
              color: LightColors.primaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Wrap(
            spacing: width * 0.08,
            children: AppTheme.values.map((valueTheme) {
              return RepaintBoundary(
                child: InkWell(
                  borderRadius: BorderRadius.circular(defaultBorderRadius(15)),
                  onTap: () {
                    setState(() {
                      verification(valueTheme);
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      radioDecoration(themeSelected, valueTheme),
                      SizedBox(height: height * 0.01),
                      Text(
                        valueTheme.name[0].toUpperCase() +
                            valueTheme.name.substring(1),
                        style: textStyle(
                          size: 15,
                          color: LightColors.secondaryText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
