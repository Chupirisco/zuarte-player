import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class InteractiveProgressBar extends StatefulWidget {
  final AudioPlayer player;

  const InteractiveProgressBar({super.key, required this.player});

  @override
  State<InteractiveProgressBar> createState() => _InteractiveProgressBarState();
}

class _InteractiveProgressBarState extends State<InteractiveProgressBar> {
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool _isUserInteracting = false;

  @override
  void initState() {
    super.initState();

    widget.player.durationStream.listen((duration) {
      if (duration != null) {
        setState(() => _totalDuration = duration);
      }
    });

    widget.player.positionStream.listen((position) {
      if (!_isUserInteracting) {
        setState(() => _currentPosition = position);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double max = _totalDuration.inMilliseconds.toDouble();
    double value = _currentPosition.inMilliseconds.clamp(0, max).toDouble();

    return Column(
      children: [
        Slider(
          min: 0,
          max: max,
          value: value,
          onChanged: (newValue) {
            setState(() {
              _isUserInteracting = true;
              _currentPosition = Duration(milliseconds: newValue.toInt());
            });
          },
          onChangeEnd: (newValue) {
            widget.player.seek(Duration(milliseconds: newValue.toInt()));
            setState(() => _isUserInteracting = false);
          },
          activeColor: Colors.greenAccent,
          inactiveColor: Colors.grey.shade300,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_formatDuration(_currentPosition)),
            Text(_formatDuration(_totalDuration)),
          ],
        ),
      ],
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
