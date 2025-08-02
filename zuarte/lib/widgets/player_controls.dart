import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

import '../constants/icons.dart';
import '../utils/size_config.dart';
import '../utils/style_configs.dart';

class PlayerControls extends StatelessWidget {
  const PlayerControls({super.key, required this.buttonHeight});
  final double buttonHeight;
  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _backButton(theme, buttonHeight),
        _pauseButton(theme, buttonHeight),
        _advanceButton(theme, buttonHeight),
      ],
    );
  }
}

Widget _backButton(ColorScheme theme, double buttonHeight) {
  return IconButton(
    onPressed: () {},
    icon: Iconify(
      AppIcons.back,
      size: iconSize(buttonHeight),
      color: iconColor(theme),
    ),
    splashColor: theme.onPrimaryContainer,
    highlightColor: theme.onPrimaryContainer,
    hoverColor: theme.onPrimaryContainer,
    padding: EdgeInsets.zero,
  );
}

Widget _pauseButton(ColorScheme theme, double buttonHeight) {
  return IconButton(
    onPressed: () {},
    icon: Iconify(
      AppIcons.pause,
      size: iconSize(buttonHeight),
      color: iconColor(theme),
    ),
    splashColor: theme.onPrimaryContainer,
    highlightColor: theme.onPrimaryContainer,
    hoverColor: theme.onPrimaryContainer,
    padding: EdgeInsets.zero,
  );
}

Widget _advanceButton(ColorScheme theme, double buttonHeight) {
  return IconButton(
    onPressed: () {},
    icon: Iconify(
      AppIcons.advance,
      size: iconSize(buttonHeight),
      color: iconColor(theme),
    ),
    splashColor: theme.onPrimaryContainer,
    highlightColor: theme.onPrimaryContainer,
    hoverColor: theme.onPrimaryContainer,
    padding: EdgeInsets.zero,
  );
}
