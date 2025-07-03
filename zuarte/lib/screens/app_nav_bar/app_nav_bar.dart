import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/constants/colors.dart';
import 'package:zuarte/constants/icons.dart';
import 'package:zuarte/constants/images.dart';
import 'package:zuarte/screens/home/home.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/utils/text_style_config.dart';

class AppNavBar extends StatefulWidget {
  const AppNavBar({super.key});

  @override
  State<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final TabController tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 1,
    );
    final heigh = overallHeight();
    final width = overallWidth();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.cardElements,
        toolbarHeight: heigh * 0.12,
        titleSpacing: 0,
        leadingWidth: 0,

        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: heigh * 0.001),
            Row(
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
            TabBar(
              controller: tabController,
              splashFactory: NoSplash.splashFactory,
              dividerHeight: 0,
              indicator: BoxDecoration(
                color: LightColors.primaryAction,
                shape: BoxShape.circle,
              ),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.all(-width * 0.02),
              tabs: [
                Tab(icon: Iconify(AppIcons.playlist, size: iconSize(22))),
                Tab(icon: Iconify(AppIcons.home, size: iconSize(22))),
                Tab(icon: Iconify(AppIcons.setting, size: iconSize(22))),
              ],
            ),
          ],
        ),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          Center(child: Text('tab 2')),
          const HomeScreen(),
          Center(child: Text('tab 3')),
        ],
      ),
    );
  }
}
