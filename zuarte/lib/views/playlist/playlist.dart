import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/viewmodels/playlist_provider.dart';

import '../../constants/icons.dart';
import '../../utils/size_config.dart';
import '../../utils/style_configs.dart';
import '../../widgets/cards.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final height = 100.h;
  final width = 100.w;

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin()),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: height * 0.02),
          Text(
            'Minhas playlists',
            textAlign: TextAlign.center,
            style: textStyle(
              size: 18,
              color: theme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: height * 0.02),
          Expanded(
            child: Consumer<PlaylistProvider>(
              builder: (context, provPl, child) {
                final int cont = provPl.playlists.length + 1;
                return ListView.separated(
                  addRepaintBoundaries: true,
                  addAutomaticKeepAlives: true,
                  itemCount: cont, // +1 'add playlist' first
                  physics: scrollEffect(),
                  separatorBuilder: (context, index) =>
                      SizedBox(height: height * 0.02),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      //'add playlist' button
                      return GestureDetector(
                        onTap: () {},
                        child: componentCard(
                          ctx: context,
                          height: height * 0.11,
                          padding: EdgeInsets.all(10.sp),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              avatarComponent(
                                height * 0.08,
                                height * 0.08,
                                AppIcons.add,
                                context,
                                null,
                              ),
                              SizedBox(width: width * 0.04),
                              Text(
                                'Criar playlist',
                                style: textStyle(
                                  size: 16,
                                  color: theme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    //playlist buttons
                    return RepaintBoundary(
                      child: GestureDetector(
                        onTap: () {},
                        child: componentCard(
                          ctx: context,
                          height: height * 0.11,
                          padding: EdgeInsets.all(10.sp),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              avatarComponent(
                                height * 0.08,
                                height * 0.08,
                                AppIcons.person,
                                context,
                                null,
                              ),
                              SizedBox(width: width * 0.04),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    provPl.playlists[index].nome.toString(),
                                    style: textStyle(
                                      size: 16,
                                      color: theme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${provPl.playlists[index].numMusicas.toString()} músicas',
                                    style: textStyle(
                                      size: 14,
                                      color: theme.secondary,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon: Iconify(
                                  AppIcons.more,
                                  size: iconSize(18),
                                  color: iconColor(theme),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
