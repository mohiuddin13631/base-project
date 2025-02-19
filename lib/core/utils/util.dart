

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'my_color.dart';

class MyUtil{

  static changeTheme(){
    /*SystemChrome.setSystemUIOverlayStyle(

        const SystemUiOverlayStyle(

            statusBarColor: MyColor.primaryColor,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: MyColor.navigationBarColor,
            systemNavigationBarIconBrightness: Brightness.dark
        )
    );*/
  }

  static onboardScreen(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }

  static dynamic getShadow(){
    return  [
      BoxShadow(
          blurRadius: 15.0,
          offset: const Offset(0, 25),
          color: Colors.grey.shade500.withOpacity(0.6),
          spreadRadius: -35.0),
    ];
  }

  static dynamic getBottomSheetShadow(){
    return  [
      BoxShadow(
        // color: MyColor.screenBgColor,
        color: Colors.grey.shade400.withOpacity(0.08),
        spreadRadius: 3,
        blurRadius: 4,
        offset: const Offset(0, 3), // changes position of shadow
      ),
    ];
  }

  static bool isImage(String path) {
    if (path.contains('.jpg')) {
      return true;
    }
    if (path.contains('.png')) {
      return true;
    }
    if (path.contains('.jpeg')) {
      return true;
    }
    return false;
  }

  static bool isDoc(String path) {
    if (path.contains('.doc')) {
      return true;
    }
    if (path.contains('.docs')) {
      return true;
    }
    return false;
  }

  static dynamic getCardShadow(){
    return  [
      BoxShadow(
        color: Colors.grey.shade400.withOpacity(0.05),
        spreadRadius: 2,
        blurRadius: 2,
        offset: const Offset(0, 3),
      ),
    ];
  }

  static String get _getDeviceType {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  return data.size.width < 550 ? 'phone' : 'tablet';
  }

  static bool get isTablet {
  return _getDeviceType == 'tablet';
  }

  static Future<void> launchUrlToBrowser(String downloadUrl) async {
    try {
      final Uri url = Uri.parse(downloadUrl);
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      print(e.toString());
    }
  }

}