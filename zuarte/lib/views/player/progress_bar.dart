import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/style_configs.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({super.key});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;
    final double valor = 0;
    return SizedBox(
      width: 85.w,
      child: Row(
        children: [
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 1.h),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 2.h),
              ),
              child: Slider(
                padding: EdgeInsets.zero,
                min: 0,
                max: 100,
                value: valor,
                secondaryTrackValue: 100,
                secondaryActiveColor: theme.onPrimaryContainer,
                activeColor: theme.secondaryContainer,
                onChanged: (value) {},
              ),
            ),
          ),
          SizedBox(width: 10),
          Text(
            '00:00',
            style: textStyle(
              size: 13,
              color: theme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
