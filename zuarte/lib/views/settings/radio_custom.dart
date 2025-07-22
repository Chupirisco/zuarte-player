import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/viewmodels/theme_provider.dart';

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

    switch (themeProvider.themeMode!) {
      case ThemeMode.system:
        {
          themeSelected = AppTheme.system;
          break;
        }
      case ThemeMode.dark:
        {
          themeSelected = AppTheme.dark;
          break;
        }
      case ThemeMode.light:
        {
          themeSelected = AppTheme.light;
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;
    final providerTheme = Provider.of<ThemeProvider>(context);
    verification(valueTheme) async {
      final themeStorage = StoreThemePreferences();

      themeSelected = valueTheme;

      switch (valueTheme) {
        case AppTheme.system:
          {
            providerTheme.toggleTheme(null);
            await themeStorage.saveTheme('system');
            break;
          }
        case AppTheme.dark:
          {
            providerTheme.toggleTheme(true);
            await themeStorage.saveTheme('dark');
            break;
          }
        case AppTheme.light:
          {
            providerTheme.toggleTheme(false);
            await themeStorage.saveTheme('light');
            break;
          }
      }
    }

    return componentCard(
      ctx: context,
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      height: height * 0.11,
      child: Row(
        children: [
          Iconify(
            AppIcons.alterTheme,
            size: iconSize(23),
            color: iconColor(theme),
          ),
          SizedBox(width: width * 0.02),
          Text(
            'Tema',
            style: textStyle(
              size: 16,
              color: theme.primary,
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
                      radioDecoration(themeSelected, valueTheme, context),
                      SizedBox(height: height * 0.01),
                      Text(
                        valueTheme.name[0].toUpperCase() +
                            valueTheme.name.substring(1),
                        style: textStyle(
                          size: 15,
                          color: theme.secondary,
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
