import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/constants/colors.dart';
import 'package:zuarte/constants/icons.dart';
import 'package:zuarte/constants/images.dart';
import 'package:zuarte/screens/app_nav_bar/player/big_player.dart';
import 'package:zuarte/screens/app_nav_bar/player/mini_player.dart';
import 'package:zuarte/screens/home/home.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/utils/text_style_config.dart';

class AppNavBar extends StatefulWidget {
  const AppNavBar({super.key});

  @override
  State<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> {
  @override
  Widget build(BuildContext context) {
    final heigh = overallHeight();
    final miniplayerController = MiniplayerController();

    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: LightColors.cardElements,
          toolbarHeight: heigh * 0.06,
          leadingWidth: 0,
          titleSpacing: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'ZUARTE',
                style: textStyle(
                  size: 15,
                  color: LightColors.primaryText,
                  fontWight: FontWeight.bold,
                ),
              ),
              Image.asset(AppImages.appLogo, height: heigh * 0.04),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(heigh * 0.06),
            child: TabBar(
              splashFactory: NoSplash.splashFactory,
              dividerHeight: 0,
              indicator: BoxDecoration(
                color: LightColors.primaryAction,
                shape: BoxShape.circle,
              ),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.all(-(7.sp)),
              tabs: [
                Tab(icon: Iconify(AppIcons.playlist, size: iconSize(22))),
                Tab(icon: Iconify(AppIcons.home, size: iconSize(22))),
                Tab(icon: Iconify(AppIcons.setting, size: iconSize(22))),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Center(child: Text('Olá')),
                const HomeScreen(),
                Center(child: Text('tab 3')),
              ],
            ),
            Miniplayer(
              duration: Duration(milliseconds: 500),
              controller: miniplayerController,
              minHeight: heigh * 0.1,
              maxHeight: heigh * 0.87,
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
