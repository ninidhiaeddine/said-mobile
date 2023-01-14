import 'package:flutter/material.dart';
import 'package:said/config/color_constants.dart';
import 'package:said/utils/material_color_builder.dart';

saidTheme () => ThemeData(
    scaffoldBackgroundColor: ColorConstants.backgroundColor,
    primarySwatch: buildMaterialColor(ColorConstants.primaryColor),
    accentColor: buildMaterialColor(const Color(0xff000000))
);