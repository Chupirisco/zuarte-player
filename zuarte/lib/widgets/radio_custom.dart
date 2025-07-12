import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';
import '../constants/icons.dart';
import '../utils/size_config.dart';
import '../utils/style_configs.dart';

class RadioCustom extends StatefulWidget {
  const RadioCustom({super.key});

  @override
  State<RadioCustom> createState() => _RadioCustomState();
}

enum Theme { system, light, dark }

class _RadioCustomState extends State<RadioCustom> {
  Theme themeSelected = Theme.light;
  @override
  Widget build(BuildContext context) {
    final height = overallHeight();
    final sizeRadio = 15.sp;
    return Container(
      height: height * 0.11,
      padding: EdgeInsets.symmetric(horizontal: overallWidth() * 0.04),
      decoration: BoxDecoration(
        color: LightColors.cardElements,
        borderRadius: BorderRadius.circular(defaultBorderRadius(18)),
      ),
      child: Row(
        children: [
          Iconify(AppIcons.alterTheme, size: iconSize(23)),
          SizedBox(width: 10),
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
            spacing: overallWidth() * 0.08,
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
                      Container(
                        height: sizeRadio,
                        width: sizeRadio,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: LightColors.borders,
                            width: 1,
                          ),
                          color: themeSelected == valueTheme
                              ? Colors.green
                              : Colors.white,
                        ),
                      ),
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
