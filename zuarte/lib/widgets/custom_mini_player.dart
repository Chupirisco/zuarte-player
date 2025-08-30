import 'dart:io';
import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:sizer/sizer.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:zuarte/services/audio_handler.dart';
import 'package:zuarte/services/service_locator.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/utils/style_configs.dart';
import 'package:zuarte/widgets/player_controlls.dart';
import 'package:zuarte/widgets/progress_bar.dart';

import '../constants/icons.dart';

final audioHandler = getIt<SongHandler>();
Widget customMiniPlayer(ColorScheme theme) {
  return StreamBuilder(
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
                        ? _buildExpandedPlayer(theme)
                        : _buildMiniPlayer(theme, percentage, snapshot.data!),
                  ),
                );
              },
            )
          : _buildExpandedPlayer(theme);
    },
  );
}

Widget _buildMiniPlayer(ColorScheme theme, double porcentage, MediaItem song) {
  final coverSize = lerpDouble(6.h, 20.h, porcentage)!;

  return Padding(
    padding: EdgeInsets.only(
      left: defaultMargin(),
      right: defaultMargin(),
      top: 1.h,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
        Expanded(child: ProgressBar(audioPlayer: audioHandler.audioPlayer)),
      ],
    ),
  );
}

Widget _buildExpandedPlayer(ColorScheme theme) {
  return ListView(
    physics: NeverScrollableScrollPhysics(),
    key: const ValueKey("expanded"),
    children: [
      Text(
        "Toxicity",
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
      Text(
        "System of a Down",
        style: TextStyle(fontSize: 12.sp, color: theme.onSurfaceVariant),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          'assets/images/capaTeste.jpg',
          height: 20.h,
          width: 10.h,
          fit: BoxFit.cover,
        ),
      ),
      SizedBox(height: 3.h),

      SizedBox(height: 3.h),
      Slider(
        value: 50,
        min: 0,
        max: 100,
        onChanged: (_) {},
        activeColor: Colors.green,
        inactiveColor: Colors.purple,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.skip_previous, size: 32),
          SizedBox(width: 8.w),
          Icon(Icons.play_arrow, size: 40),
          SizedBox(width: 8.w),
          Icon(Icons.skip_next, size: 32),
        ],
      ),
      SizedBox(height: 3.h),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Próxima",
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: theme.onSurfaceVariant,
          ),
        ),
      ),
      SizedBox(height: 1.h),
      ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset("assets/images/capaTeste.jpg"),
        ),
        title: Text("Walk"),
        subtitle: Text("Foo Fighters"),
      ),
    ],
  );
}
