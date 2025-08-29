import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:sizer/sizer.dart';

Widget customMiniPlayer(ColorScheme theme) {
  return Miniplayer(
    minHeight: 10.h,
    maxHeight: 100.h - 45.sp,
    builder: (height, percentage) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 100),
        decoration: BoxDecoration(
          color: percentage < 0.5 ? theme.primaryContainer : theme.surface,
          border: Border(top: BorderSide(color: theme.onPrimary)),
        ),

        child: Stack(
          children: [
            Align(
              alignment: Alignment.lerp(
                Alignment.centerLeft,
                Alignment.center,
                percentage,
              )!,
              child: Image.asset(
                'assets/images/capaTeste.jpg',
                height: (percentage * 20.h) + 5.h,
                width: (percentage * 20.h) + 5.h,
              ),
            ),
          ],
        ),
      );
    },
  );
}
