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
  return StreamBuilder<MediaItem?>(
    stream: audioHandler.mediaItem.stream,
    builder: (context, snapshot) {
      final song = snapshot.data;
      return song == null
          ? MiniPlayerEmpty(theme: theme)
          : MiniPlayerActive(theme: theme, song: song);
    },
  );
}

class MiniPlayerActive extends StatelessWidget {
  final ColorScheme theme;
  final MediaItem song;

  const MiniPlayerActive({super.key, required this.theme, required this.song});

  @override
  Widget build(BuildContext context) {
    return Miniplayer(
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin()),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: isExpanded
                  ? _buildExpandedPlayer(theme, percentage, song, height)
                  : _buildMiniPlayer(theme, percentage, song),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMiniPlayer(
    ColorScheme theme,
    double percentage,
    MediaItem song,
  ) {
    final coverSize = lerpDouble(6.h, 20.h, percentage)!;

    return Padding(
      padding: EdgeInsets.only(top: 1.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          divider(theme),
          Stack(
            alignment: Alignment.center,
            children: [
              (song.artUri == null || song.artUri.toString().isEmpty)
                  ? SizedBox(height: coverSize)
                  : AnimatedAlign(
                      duration: const Duration(milliseconds: 0),
                      alignment: Alignment.lerp(
                        Alignment.centerLeft,
                        Alignment.center,
                        percentage,
                      )!,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: FadeInImage(
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
                  opacity: (1 - percentage).clamp(0.0, 1.0),
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
                            if (song.artist != null)
                              Text(
                                song.artist!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textStyle(
                                  size: 14,
                                  color: theme.secondary,
                                ),
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
          Flexible(
            fit: FlexFit.loose,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 0),
              opacity: (1 - percentage).clamp(0.0, 1.0),
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
        physics: const NeverScrollableScrollPhysics(),
        key: const ValueKey("expanded"),
        padding: EdgeInsets.symmetric(horizontal: defaultMargin()),
        child: Column(
          children: [
            divider(theme),
            SizedBox(height: height * 0.1),
            Text(
              song.title,
              style: textStyle(
                size: 16,
                color: theme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (song.artist != null)
              Text(
                song.artist!,
                style: textStyle(size: 14, color: theme.secondary),
              ),
            SizedBox(height: height * 0.03),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: (song.artUri == null)
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
            SizedBox(
              width: coverSize,
              child: PlayerControls(buttonHeight: coverSize * 0.08),
            ),
            SizedBox(height: height * 0.03),
            ProgressBar(audioPlayer: audioHandler.audioPlayer),
            SizedBox(height: height * 0.05),
            Consumer<SongProvider>(
              builder: (context, pro, child) {
                final index = audioHandler.audioPlayer.currentIndex;
                if (index == null || index + 1 >= pro.songs.length) {
                  return const SizedBox();
                }
                final nextSong = pro.songs[index + 1];
                return SongItem(
                  id: int.parse(nextSong.displayDescription!),
                  isPlaying: song == nextSong,
                  title: formattedTitle(nextSong.title),
                  artist: nextSong.artist,
                  onSongTap: () async {
                    await songHandler.skipToQueueItem(index + 1);
                    await songHandler.play();
                  },
                  art: nextSong.artUri,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Divider divider(ColorScheme theme) => Divider(
    endIndent: 35.w,
    indent: 35.w,
    height: 0,
    thickness: 5,
    color: theme.onPrimary,
  );
}

class MiniPlayerEmpty extends StatelessWidget {
  final ColorScheme theme;
  const MiniPlayerEmpty({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Miniplayer(
      minHeight: 13.h,
      maxHeight: 13.h,
      builder: (height, percentage) {
        return Container(
          decoration: BoxDecoration(
            color: theme.primaryContainer,
            border: Border(top: BorderSide(color: theme.onPrimary)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(defaultMargin()),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Iconify(
                      AppIcons.musics,
                      size: iconSize(20),
                      color: theme.secondary,
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'Nenhuma música selecionada',
                      style: textStyle(
                        color: theme.secondary,
                        size: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      'Toque em uma música para começar a tocar',
                      style: textStyle(color: theme.secondary, size: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
