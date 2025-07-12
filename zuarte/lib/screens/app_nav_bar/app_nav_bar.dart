import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/constants/colors.dart';
import 'package:zuarte/constants/icons.dart';
import 'package:zuarte/constants/images.dart';
import 'package:zuarte/screens/player/big_player.dart';
import 'package:zuarte/screens/player/mini_player.dart';
import 'package:zuarte/screens/home/home.dart';
import 'package:zuarte/screens/settings/settings.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/utils/style_configs.dart';

class AppNavBar extends StatefulWidget {
  const AppNavBar({super.key});

  @override
  State<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final heigh = overallHeight();
    final miniplayerController = MiniplayerController();
    final TabController tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 1,
      animationDuration: Duration(milliseconds: 500),
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(heigh * 0.1),
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

                      Image.asset(
                        AppImages.appLogo,
                        height: overallHeight() * 0.04,
                      ),
                    ],
                  ),

                  TabBar(
                    controller: tabController,
                    splashFactory: NoSplash.splashFactory,
                    dividerHeight: 0,
                    indicator: BoxDecoration(
                      color: LightColors.primaryAction,
                      shape: BoxShape.circle,
                    ),
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding: EdgeInsets.all(-7.sp),
                    tabs: [
                      Tab(icon: Iconify(AppIcons.playlist, size: iconSize(22))),
                      Tab(icon: Iconify(AppIcons.home, size: iconSize(22))),
                      Tab(icon: Iconify(AppIcons.setting, size: iconSize(22))),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      body: Stack(
        children: [
          TabBarView(
            controller: tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Center(child: Text('Olá')),
              const HomeScreen(),
              const SettingsScreen(),
            ],
          ),
          Miniplayer(
            duration: Duration(milliseconds: 500),
            controller: miniplayerController,
            minHeight: heigh * 0.13,
            maxHeight: heigh * 0.87,
            backgroundColor: LightColors.background,
            builder: (height, percentage) =>
                percentage <= 0.3 ? miniPlayer(height) : bigPlayer(height),
          ),
        ],
      ),
    );
  }
}
