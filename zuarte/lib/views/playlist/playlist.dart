import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/constants/colors.dart';
import 'package:zuarte/constants/icons.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/utils/style_configs.dart';
import 'package:zuarte/views/playlist/playlist_styles.dart';
import 'package:zuarte/views/settings/settings_styles.dart';
import 'package:zuarte/widgets/cards.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final height = overallHeight();
  final width = overallWidth();
  final playlists = [
    {'name': 'Playlist 1', 'count': 25},
    {'name': 'Playlist 2', 'count': 13},
  ];
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin()),
      physics: scrollEffect(),
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
        //card add playlist
        ElevatedButton(
          style: playlistButtonStyle(height * 0.11, width),
          onPressed: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              playlistAvatarComponent(
                height * 0.08,
                height * 0.08,
                AppIcons.add,
              ),
              SizedBox(width: width * 0.04),
              Text(
                'Criar playlist',
                style: textStyle(
                  size: 16,
                  color: LightColors.primaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),

        ...playlists.map((playlist) {
          return Padding(
            padding: EdgeInsets.only(top: height * 0.02),
            child: Material(
              color: Colors.transparent,
              child: ElevatedButton(
                style: playlistButtonStyle(height * 0.11, width),
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    playlistAvatarComponent(
                      height * 0.08,
                      height * 0.08,
                      AppIcons.person,
                    ),
                    SizedBox(width: width * 0.04),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          playlist['name'].toString(),
                          style: textStyle(
                            size: 16,
                            color: LightColors.primaryText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${playlist['count'].toString()} músicas',
                          style: textStyle(
                            size: 14,
                            color: LightColors.secondaryText,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Iconify(AppIcons.more, size: iconSize(18)),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
