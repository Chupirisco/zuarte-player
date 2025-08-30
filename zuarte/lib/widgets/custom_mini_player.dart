import 'dart:io';
import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:zuarte/services/audio_handler.dart';
import 'package:zuarte/services/service_locator.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/utils/style_configs.dart';
import 'package:zuarte/viewmodels/audio_player_provider.dart';
import 'package:zuarte/widgets/player_controlls.dart';
import 'package:zuarte/widgets/progress_bar.dart';
import 'package:zuarte/widgets/song_item.dart';

import '../constants/icons.dart';
import '../utils/formatted_title.dart';

final audioHandler = getIt<SongHandler>();
Widget customMiniPlayer(ColorScheme theme) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: defaultMargin()),
    child: StreamBuilder(
      stream: audioHandler.mediaItem.stream,
      builder: (context, snapshot) {
        return snapshot.data != null
            ? Miniplayer(
                minHeight: 13.h,
                maxHeight: 100.h - 45.sp,
                builder: (height, percentage) {
                  final isExpanded = percentage > 0.5;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: theme.surface,
                      border: Border(top: BorderSide(color: theme.onPrimary)),
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) =>
                          FadeTransition(opacity: animation, child: child),
                      child: isExpanded
                          ? _buildExpandedPlayer(
                              theme,
                              percentage,
                              snapshot.data!,
                              height,
                            )
                          : _buildMiniPlayer(theme, percentage, snapshot.data!),
                    ),
                  );
                },
              )
            : _buildMiniPlayer(
                theme,
                0,
                MediaItem(
                  id: '',
                  title: 'Nenhuma música selecionada',
                  artist: '',
                ),
              );
      },
    ),
  );
}

Widget _buildMiniPlayer(ColorScheme theme, double porcentage, MediaItem song) {
  final coverSize = lerpDouble(6.h, 20.h, porcentage)!;

  return Padding(
    padding: EdgeInsets.only(top: 1.h),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        divider(theme),
        Stack(
          alignment: Alignment.center,
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 0),
              alignment: Alignment.lerp(
                Alignment.centerLeft,
                Alignment.center,
                porcentage,
              )!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: song.artUri == null
                    ? Iconify(AppIcons.person)
                    : FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        image: FileImage(File.fromUri(song.artUri!)),
                        fadeInDuration: const Duration(milliseconds: 700),
                        fit: BoxFit.cover,
                        width: coverSize,
                        height: coverSize,
                      ),
              ),
            ),

            Positioned.fill(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 0),
                opacity: (1 - porcentage).clamp(0.0, 1.0),
                child: Row(
                  children: [
                    SizedBox(width: 6.h + 3.w),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            song.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textStyle(
                              fontWeight: FontWeight.bold,
                              size: 15,
                              color: theme.primary,
                            ),
                          ),
                          Text(
                            song.artist!,
                            maxLines: 13,
                            overflow: TextOverflow.ellipsis,
                            style: textStyle(size: 14, color: theme.secondary),
                          ),
                        ],
                      ),
                    ),
                    PlayerControls(buttonHeight: 19),
                  ],
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 0),
            opacity: (1 - porcentage).clamp(0.0, 1.0),
            child: ProgressBar(audioPlayer: audioHandler.audioPlayer),
          ),
        ),
      ],
    ),
  );
}

Widget _buildExpandedPlayer(
  ColorScheme theme,
  double percentage,
  MediaItem song,
  double height,
) {
  final coverSize = lerpDouble(height * 0.06, height * 0.35, percentage)!;
  return SizedBox(
    height: height,
    width: double.infinity,
    child: SingleChildScrollView(
      padding: EdgeInsets.only(
        top: height * 0.01,
        left: defaultMargin(),
        right: defaultMargin(),
      ),
      physics: NeverScrollableScrollPhysics(),
      key: const ValueKey("expanded"),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          divider(theme),
          Column(
            children: [
              SizedBox(height: height * 0.1),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 0),
                opacity: percentage.clamp(0.0, 1.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      song.title,
                      style: textStyle(
                        size: 16,
                        color: theme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      song.artist!,
                      style: textStyle(size: 14, color: theme.secondary),
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.01),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: song.artUri == null
                          ? Iconify(AppIcons.person)
                          : FadeInImage(
                              placeholder: MemoryImage(kTransparentImage),
                              image: FileImage(File.fromUri(song.artUri!)),
                              fadeInDuration: const Duration(milliseconds: 700),
                              fit: BoxFit.cover,
                              width: coverSize,
                              height: coverSize,
                            ),
                    ),
                    SizedBox(height: height * 0.03),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 0),
                      opacity: percentage.clamp(0.0, 1.0),
                      child: SizedBox(
                        width: coverSize,
                        child: PlayerControls(buttonHeight: coverSize * 0.08),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.03),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 0),
            opacity: percentage.clamp(0.0, 1.0),
            child: ProgressBar(audioPlayer: audioHandler.audioPlayer),
          ),
          SizedBox(height: height * 0.16),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 0),
            opacity: percentage.clamp(0.0, 1.0),
            child: Column(
              children: [
                Consumer<SongProvider>(
                  builder: (context, pro, child) {
                    int musicIndex = audioHandler.audioPlayer.currentIndex! + 1;
                    final nexSong = pro.songs[musicIndex];
                    return SongItem(
                      id: int.parse(nexSong.displayDescription!),
                      isPlaying: song == nexSong,
                      title: formattedTitle(nexSong.title),
                      artist: nexSong.artist,
                      onSongTap: () async {
                        await songHandler.skipToQueueItem(musicIndex);
                        await songHandler.play();
                      },
                      art: nexSong.artUri,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Divider divider(ColorScheme theme) {
  return Divider(
    endIndent: 35.w,
    indent: 35.w,
    height: 0,
    thickness: 5,
    color: theme.onPrimary,
  );
}
