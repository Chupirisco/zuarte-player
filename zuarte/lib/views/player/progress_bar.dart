import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
      width: 100.w * 0.8,
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
    );
  }
}
