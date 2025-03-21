
import 'package:flutter/material.dart';
import 'package:base_project/core/utils/my_color.dart';
import 'package:base_project/core/utils/style.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Inter',
  primaryColor: MyColor.getPrimaryColor(),
  brightness: Brightness.light,
  scaffoldBackgroundColor: MyColor.getScreenBgColor(),
  hintColor: MyColor.hintTextColor,
  focusColor: MyColor.fieldDisableBorderColor,
  buttonTheme: ButtonThemeData(
    buttonColor: MyColor.getPrimaryColor(),
  ),
  cardColor: MyColor.cardBgColor,
  appBarTheme: AppBarTheme(
    backgroundColor: MyColor.getAppbarBgColor(),
    elevation: 0,
    titleTextStyle: regularLarge.copyWith(color: MyColor.colorWhite),
    iconTheme: const IconThemeData(
      size: 20,
      color: MyColor.colorWhite
    )
  ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(MyColor.colorWhite),
      fillColor: MaterialStateProperty.all(MyColor.colorWhite),
      overlayColor: MaterialStateProperty.all(MyColor.greenSuccessColor),
    ));