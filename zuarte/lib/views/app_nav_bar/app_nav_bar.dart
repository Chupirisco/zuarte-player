import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/constants/icons.dart';
import 'package:zuarte/constants/images.dart';
import 'package:zuarte/viewmodels/miniplayer_controller_provider.dart';
import 'package:zuarte/views/player/big_player.dart';
import 'package:zuarte/views/player/mini_player.dart';
import 'package:zuarte/views/list_of_songs/list_of_songs.dart';
import 'package:zuarte/views/playlist/playlist.dart';
import 'package:zuarte/views/settings/settings.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/utils/style_configs.dart';

class AppNavBar extends StatefulWidget {
  const AppNavBar({super.key});

  @override
  State<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> with TickerProviderStateMixin {
  late TabController tabController;
  late final bool checkSize;
  late final double minPlayerHeight;
  late final double maxPlayerHeight;

  final double height = 100.h;
  final double width = 100.w;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 1,
      animationDuration: Duration(milliseconds: 700),
    );

    checkSize = height >= width;
    minPlayerHeight = checkSize ? height * 0.13 : width * 0.12;
    maxPlayerHeight = checkSize ? height * 0.88 : width * 0.9;
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;
    final provider = Provider.of<MiniplayerControllerProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45.sp),
        child: RepaintBoundary(
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.vertical(
              bottom: Radius.circular(defaultBorderRadius(20)),
            ),
            child: AppBar(
              backgroundColor: theme.primaryContainer,
              automaticallyImplyLeading: false,
              flexibleSpace: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'ZUARTE',
                          style: textStyle(
                            size: 15,
                            color: theme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Image.asset(AppImages.appLogo, height: 23.sp),
                      ],
                    ),

                    TabBar(
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      indicatorAnimation: TabIndicatorAnimation.linear,
                      controller: tabController,
                      splashFactory: NoSplash.splashFactory,
                      dividerHeight: 0,
                      indicator: BoxDecoration(
                        color: theme.onPrimaryContainer,
                        shape: BoxShape.circle,
                      ),
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorPadding: EdgeInsets.all(-8.sp),
                      tabs: [
                        Tab(
                          icon: Iconify(
                            AppIcons.playlist,
                            size: iconSize(22),
                            color: iconColor(theme),
                          ),
                        ),
                        Tab(
                          icon: Iconify(
                            AppIcons.musics,
                            size: iconSize(22),
                            color: iconColor(theme),
                          ),
                        ),
                        Tab(
                          icon: Iconify(
                            AppIcons.setting,
                            size: iconSize(22),
                            color: iconColor(theme),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      body: RepaintBoundary(
        child: Stack(
          children: [
            TabBarView(
              controller: tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const PlaylistScreen(),
                const ListOfSongs(),
                const SettingsScreen(),
              ],
            ),
            Miniplayer(
              duration: const Duration(milliseconds: 500),
              controller: provider.controller,
              minHeight: minPlayerHeight,
              maxHeight: maxPlayerHeight,
              backgroundColor: theme.surface,
              builder: (height, percentage) => percentage <= 0.3
                  ? RepaintBoundary(
                      child: miniPlayer(height, provider, context),
                    )
                  : RepaintBoundary(
                      child: bigPlayer(height, provider, context),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
