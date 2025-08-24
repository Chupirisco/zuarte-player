import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:zuarte/viewmodels/audio_player_provider.dart';
import 'package:zuarte/widgets/progress_bar.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/utils/style_configs.dart';
import 'package:zuarte/widgets/player_controls.dart';

import '../../services/audio_handler.dart';
import '../../widgets/custom_divider.dart';

final songHandler = GetIt.instance<SongHandler>();
class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;
    return StreamBuilder<MediaItem?>(
      stream: songHandler.mediaItem.stream,
      builder: (context, snapshot) {
        MediaItem? playingSong = snapshot.data;
        return playingSong == null
            ? const SizedBox.shrink()
            : _buildCard(context, playingSong);
      },
    );
  }

  Card _buildCard(BuildContext context,MediaItem playingSong) {
    return Card(child: Stack(children: [
      if(playingSong.)
    ],));
  }
}

  //  Consumer<AudioPlayerProvider>(
  //   builder: (context, provider, child) => Container(
  //     decoration: BoxDecoration(
  //       color: theme.primaryContainer,
  //       borderRadius: BorderRadius.vertical(
  //         top: Radius.circular(defaultBorderRadius(20)),
  //       ),
  //     ),
  //     padding: EdgeInsets.symmetric(horizontal: defaultMargin()),

  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,

  //       children: [
  //         Align(alignment: Alignment.topCenter, child: customDivider(theme)),
  //         const Spacer(),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Text(
  //                     provider.currentMusic.title,
  //                     overflow: TextOverflow.ellipsis,
  //                     style: textStyle(
  //                       size: 16,
  //                       color: theme.primary,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                   ?provider.currentMusic.author == null
  //                       ? null
  //                       : Text(
  //                           provider.currentMusic.author!,
  //                           overflow: TextOverflow.ellipsis,
  //                           style: textStyle(
  //                             size: 14,
  //                             color: theme.secondary,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                 ],
  //               ),
  //             ),
  //             //control icons
  //             PlayerControls(buttonHeight: 20),
  //           ],
  //         ),

  //         ProgressBar(audioPlayer: provider.player),

  //         const Spacer(),
  //       ],
  //     ),
  //   ),
  // );


