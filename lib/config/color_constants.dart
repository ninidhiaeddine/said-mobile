import 'package:flutter/material.dart';

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
  'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}

class ColorConstants {
  static Color backgroundColor = hexToColor('#ecf1ff');
  static Color primaryColor = hexToColor('#f59e0b');
  static Color secondaryColor = hexToColor('#1E3A8A');
  static Color accentColor = hexToColor('#000000');
  static Color textFieldColor = hexToColor('#cbd0df');
}