import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/style_configs.dart';

Widget musicInformation(BuildContext context, ColorScheme theme) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
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

      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/images/capaTeste.jpg',
          height: 35.h,
          width: 34.h,
          fit: BoxFit.fill,
        ),
      ),
    ],
  );
}

Widget nextMusic(BuildContext context, ColorScheme theme) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
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
      const SizedBox(height: 5),
      Material(
        color: Colors.transparent,
        child: ListTile(
          minTileHeight: 5.h,
          tileColor: theme.primaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(25),
          ),
          leading: Text('capa'),
          title: Text('Nome'),
          subtitle: Text('Cantor'),
          trailing: Text('Função'),
          onTap: () {},
        ),
      ),
    ],
  );
}
