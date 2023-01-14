import 'package:flutter/material.dart';
import 'package:said/utils/materialColorBuilder.dart';

SaidTheme () => ThemeData(
    scaffoldBackgroundColor: const Color(0xffecf1ff),
    primarySwatch: buildMaterialColor(const Color(0xfff59e0b)),
    accentColor: buildMaterialColor(const Color(0xff000000))
);