import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:zuarte/constants/colors.dart';
import 'package:zuarte/constants/icons.dart';
import 'package:zuarte/screens/app_nav_bar/player/progress_bar.dart';

Widget miniPlayer(double height) {
  final AudioPlayer teste = AudioPlayer();
  return Container(
    color: LightColors.cardElements,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nenhuma música selecionada'),
            IconButton(onPressed: () {}, icon: Iconify(AppIcons.back)),
            IconButton(onPressed: () {}, icon: Iconify(AppIcons.play)),
            IconButton(onPressed: () {}, icon: Iconify(AppIcons.advance)),
          ],
        ),
        InteractiveProgressBar(player: teste),
      ],
    ),
  );
}
