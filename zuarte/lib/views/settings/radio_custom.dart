import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

import '../../constants/colors.dart';
import '../../constants/icons.dart';
import '../../widgets/cards.dart';
import 'settings_styles.dart';
import '../../utils/size_config.dart';
import '../../utils/style_configs.dart';

class RadioCustom extends StatefulWidget {
  const RadioCustom({super.key});

  @override
  State<RadioCustom> createState() => _RadioCustomState();
}

enum Theme { system, light, dark }

class _RadioCustomState extends State<RadioCustom> {
  Theme themeSelected = Theme.light;
  final width = overallWidth();
  final height = overallHeight();

  @override
  Widget build(BuildContext context) {
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
            children: Theme.values.map((valueTheme) {
              return RepaintBoundary(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      themeSelected = valueTheme;
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
