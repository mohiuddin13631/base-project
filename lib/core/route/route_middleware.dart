import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:base_project/core/route/route.dart';
import 'package:base_project/data/model/user/user.dart';

import '../../data/services/push_notification_service.dart';
import '../helper/shared_preference_helper.dart';
class RouteMiddleWare {
  //
  static Future<void> checkUserStatusAndGoToNextStep({User? user, String accessToken = "", String tokenType = ""}) async {
    bool needEmailVerification = user?.ev == "1" ? false : true;
    bool needSmsVerification = user?.sv == '1' ? false : true;
    bool isTwoFactorEnable = user?.tv == '1' ? false : true;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(SharedPreferenceHelper.userIdKey, user?.id.toString() ?? '-1');
    await sharedPreferences.setString(SharedPreferenceHelper.userEmailKey, user?.email ?? '');
    await sharedPreferences.setString(SharedPreferenceHelper.userPhoneNumberKey, user?.mobile ?? '');
    await sharedPreferences.setString(SharedPreferenceHelper.userNameKey, user?.username ?? '');
    if (accessToken.isNotEmpty) {
      await sharedPreferences.setString(SharedPreferenceHelper.accessTokenKey, accessToken);
      await sharedPreferences.setString(SharedPreferenceHelper.accessTokenType, tokenType);
    }
    bool isProfileCompleteEnable = user?.profileComplete == '0' ? true : false;
    if (isProfileCompleteEnable) {
      Get.offAndToNamed(RouteHelper.profileCompleteScreen);
    } else if (needEmailVerification) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen);
    } else if (needSmsVerification) {
      Get.offAndToNamed(RouteHelper.smsVerificationScreen);
    } else if (isTwoFactorEnable) {
      Get.offAndToNamed(RouteHelper.twoFactorScreen);
    } else {
      // printx('go to home form route middleware');
      PushNotificationService(apiClient: Get.find()).sendUserToken();
      Get.offAndToNamed(RouteHelper.bottomNavBar, arguments: [true]);
    }
  }
//
}