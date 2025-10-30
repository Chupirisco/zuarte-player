import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/utils/style_configs.dart';
import 'package:zuarte/widgets/buttton_component.dart';

Widget modalDelete(
  BuildContext context,
  ColorScheme theme,
  String title,
  VoidCallback funcion,
) {
  return MediaQuery.removeViewPadding(
    context: context,
    removeBottom: true,
    child: Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 3.h),
          Text(
            'Excluir $title',
            style: textStyle(
              size: 16,
              color: theme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 0.h),
          Text(
            'Tem certeza que deseja excluir a $title?',
            style: textStyle(size: 14, color: theme.secondary),
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buttonComponent(
                surfaceColor: theme.primaryContainer,
                child: Text(
                  'Cancelar',
                  style: textStyle(size: 15, color: theme.primary),
                ),
                onClick: () => Navigator.of(context).pop(),
              ),
              buttonComponent(
                surfaceColor: theme.error,
                child: Text(
                  'Excluir',
                  style: textStyle(size: 15, color: Color(0xFFF9F9F9)),
                ),
                onClick: funcion,
              ),
            ],
          ),
          SizedBox(height: 3.h),
        ],
      ),
    ),
  );
}
