import 'package:flutter/material.dart';
import 'package:zuarte/constants/colors.dart';
import 'package:zuarte/utils/size_config.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({super.key});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    final double valor = 0;
    return Row(
      children: [
        SizedBox(
          width: overallWidth() * 0.8,
          child: Slider(
            padding: EdgeInsets.zero,
            min: 0,
            max: 100,
            value: valor,
            secondaryTrackValue: 100,
            secondaryActiveColor: LightColors.primaryAction,
            activeColor: LightColors.details,
            onChanged: (value) {},
          ),
        ),
        const Spacer(),
        // Text(
        //   '00:00',
        //   style: textStyle(size: 14, color: LightColors.primaryText),
        // ),
      ],
    );
  }
}
