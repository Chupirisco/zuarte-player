import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/constants/colors.dart';
import 'package:zuarte/constants/icons.dart';
import 'package:zuarte/constants/images.dart';
import 'package:zuarte/views/player/big_player.dart';
import 'package:zuarte/views/player/mini_player.dart';
import 'package:zuarte/views/home/home.dart';
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
  late MiniplayerController miniplayerController;
  late TabController tabController;
  final height = 100.h;
  final width = 100.w;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 1,
      animationDuration: Duration(milliseconds: 700),
    );
    miniplayerController = MiniplayerController();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    miniplayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool checkSize = height >= width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(checkSize ? height * 0.11 : width * 0.1),
        child: RepaintBoundary(
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.vertical(
              bottom: Radius.circular(defaultBorderRadius(20)),
            ),
            child: AppBar(
              backgroundColor: LightColors.cardElements,
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
                            color: LightColors.primaryText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Image.asset(AppImages.appLogo, height: 23.sp),
                      ],
                    ),

                    TabBar(
                      indicatorAnimation: TabIndicatorAnimation.linear,
                      controller: tabController,
                      splashFactory: NoSplash.splashFactory,
                      dividerHeight: 0,
                      indicator: BoxDecoration(
                        color: LightColors.primaryAction,
                        shape: BoxShape.circle,
                      ),
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorPadding: EdgeInsets.all(-8.sp),
                      tabs: [
                        Tab(
                          icon: Iconify(AppIcons.playlist, size: iconSize(22)),
                        ),
                        Tab(icon: Iconify(AppIcons.home, size: iconSize(22))),
                        Tab(
                          icon: Iconify(AppIcons.setting, size: iconSize(22)),
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
                const HomeScreen(),
                const SettingsScreen(),
              ],
            ),
            Miniplayer(
              duration: Duration(milliseconds: 500),
              controller: miniplayerController,
              minHeight: checkSize ? height * 0.13 : width * 0.12,
              maxHeight: checkSize ? height * 0.87 : width * 0.88,
              backgroundColor: LightColors.background,
              builder: (height, percentage) =>
                  percentage <= 0.3 ? miniPlayer(height) : bigPlayer(height),
            ),
          ],
        ),
      ),
    );
  }
}
