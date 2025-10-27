import 'package:flutter/material.dart';

ElevatedButton buttonComponent({
  required Widget child,
  required VoidCallback onClick,
}) {
  return ElevatedButton(onPressed: onClick, child: child);
}
