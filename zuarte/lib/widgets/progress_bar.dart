import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sizer/sizer.dart';

import '../utils/style_configs.dart';

class ProgressBar extends StatefulWidget {
  final AudioPlayer audioPlayer;

  const ProgressBar({super.key, required this.audioPlayer});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  // value that refers to the slider ball
  double _sliderValue = 0;
  // Flag to indicate whether the user is dragging the slider
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return StreamBuilder<Duration>(
      stream: widget.audioPlayer.positionStream,
      builder: (_, snapshot) {
        final position = snapshot.data ?? Duration.zero;
        final duration = widget.audioPlayer.duration ?? Duration.zero;

        // If there is no music loaded, it freezes at the beginning and shows no progress
        if (duration == Duration.zero) {
          _sliderValue = 0;
          return SizedBox(
            width: 85.w,
            child: Row(
              children: [
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 1.h,
                      ),
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 2.h),
                    ),
                    child: Slider(
                      min: 0,
                      max: 1,
                      value: 0,
                      activeColor: theme.secondaryContainer,
                      inactiveColor: theme.onPrimaryContainer,
                      onChanged: (_) {},
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                _buildDurationText(theme, Duration.zero),
              ],
            ),
          );
        }

        // Maximum slider value, based on the total song duration (in milliseconds)
        final double maxValue = duration.inMilliseconds.toDouble().clamp(
          1,
          double.infinity,
        );

        // Updates the slider only if the user is not dragging manually
        if (!_isDragging) {
          _sliderValue = position.inMilliseconds.clamp(0, maxValue).toDouble();
        }

        // Default layout when music is playing
        return SizedBox(
          width: 85.w,
          child: Row(
            children: [
              Expanded(child: _buildSlider(theme, maxValue)),
              const SizedBox(width: 10),
              _buildDurationText(theme, duration),
            ],
          ),
        );
      },
    );
  }

  // Creates and styles the Slider that controls the position of the music
  Widget _buildSlider(ColorScheme theme, double maxValue) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 1.h),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 2.h),
      ),
      child: Slider(
        min: 0,
        max: maxValue,
        value: _sliderValue,
        activeColor: theme.secondaryContainer,
        inactiveColor: theme.onPrimaryContainer,
        onChanged: _onSliderChange,
        onChangeEnd: _onSliderChangeEnd,
      ),
    );
  }

  // show duration text
  Widget _buildDurationText(ColorScheme theme, Duration duration) {
    return Text(
      _formatDuration(duration),
      style: textStyle(
        size: 13,
        color: theme.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Updates the slider value while the user is dragging
  void _onSliderChange(double value) {
    setState(() {
      _isDragging = true;
      _sliderValue = value;
    });
  }

  // Sets the new audio position when the user releases the slider
  void _onSliderChangeEnd(double value) {
    widget.audioPlayer.seek(Duration(milliseconds: value.toInt()));
    setState(() => _isDragging = false);
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
