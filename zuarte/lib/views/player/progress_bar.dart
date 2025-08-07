import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sizer/sizer.dart';

import '../../utils/style_configs.dart';

class ProgressBar extends StatefulWidget {
  final AudioPlayer audioPlayer;

  const ProgressBar({super.key, required this.audioPlayer});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  double _sliderValue = 0;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;

    return StreamBuilder<Duration>(
      stream: widget.audioPlayer.positionStream,
      builder: (context, snapshot) {
        final position = snapshot.data ?? Duration.zero;
        final duration = widget.audioPlayer.duration ?? Duration.zero;

        final double max = duration.inMilliseconds.toDouble();

        // Atualiza o valor do slider APENAS se não estiver sendo arrastado
        if (!_isDragging) {
          _sliderValue = position.inMilliseconds.clamp(0, max).toDouble();
        }

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
                    min: 0,
                    max: max > 0 ? max : 1,
                    value: _sliderValue,
                    activeColor: theme.secondaryContainer,
                    inactiveColor: theme.onPrimaryContainer,
                    onChanged: (newValue) {
                      setState(() {
                        _isDragging = true;
                        _sliderValue = newValue;
                      });
                    },
                    onChangeEnd: (newValue) {
                      widget.audioPlayer.seek(
                        Duration(milliseconds: newValue.toInt()),
                      );
                      setState(() {
                        _isDragging = false;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                _formatDuration(duration),
                style: textStyle(
                  size: 13,
                  color: theme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
