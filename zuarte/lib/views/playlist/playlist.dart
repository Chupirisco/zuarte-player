import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:zuarte/constants/colors.dart';
import 'package:zuarte/constants/icons.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/utils/style_configs.dart';
import 'package:zuarte/widgets/cards.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final height = overallHeight();
  final width = overallWidth();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin()),
      children: [
        SizedBox(height: height * 0.02),
        Text(
          'Minhas playlists',
          textAlign: TextAlign.center,
          style: textStyle(
            size: 18,
            color: LightColors.primaryText,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: height * 0.02),
        componentCard(
          height: height * 0.11,
          child: GestureDetector(
            child: Row(
              children: [
                ElevatedButton(onPressed: () {}, child: Iconify(AppIcons.add)),
                SizedBox(width: width * 0.04),
                Text(
                  'Criar playlist',
                  style: textStyle(
                    size: 16,
                    color: LightColors.primaryText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
