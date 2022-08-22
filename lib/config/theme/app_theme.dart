import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nash2en_masr/utils/app_color.dart';
import 'package:nash2en_masr/utils/app_strings.dart';

ThemeData appTheme(){
  return ThemeData(
    primaryColor: AppColor.primaryColor,
    hintColor: AppColor.hintColorColor,
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    fontFamily: AppStrings.appFont,
);
}