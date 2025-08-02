import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/views/player/progress_bar.dart';
import 'package:zuarte/widgets/player_controls.dart';
import '../../utils/style_configs.dart';

Widget bigPlayer(double height, BuildContext context) {
  final ColorScheme theme = Theme.of(context).colorScheme;

  return SafeArea(
    child: SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 5 + 0.1.h,
            width: 24.w,
            margin: EdgeInsets.symmetric(horizontal: 38.w),
            decoration: BoxDecoration(
              color: theme.onPrimary,
              borderRadius: BorderRadius.circular(defaultBorderRadius(10)),
            ),
          ),
          SizedBox(height: 10.h),

          Text(
            'Toxicity',
            style: textStyle(
              size: 18,
              color: theme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'System of Down',
            style: textStyle(
              size: 14,
              color: theme.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 1.h),

          // Imagem comentada — se for usar, prefira BoxFit.cover
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/capaTeste.jpg',
              height: 30.h,
              width: 60.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 60.w, child: PlayerControls(buttonHeight: 25)),

          SizedBox(height: 2.h),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '00:00',
              style: textStyle(
                size: 13,
                color: theme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const ProgressBar(),

          SizedBox(height: 5.h),

          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Text(
              'Próxima',
              style: textStyle(
                size: 16,
                color: theme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: theme.primaryContainer,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                const Text('capa'),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [Text('Nome'), Text('Cantor')],
                  ),
                ),
                const Text('Função'),
              ],
            ),
          ),

          SizedBox(height: 3.h),
        ],
      ),
    ),
  );
}
