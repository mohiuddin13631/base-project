import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:base_project/data/controller/common/theme_controller.dart';
import 'package:base_project/data/controller/localization/localization_controller.dart';
import 'package:base_project/data/controller/splash/splash_controller.dart';
import 'package:base_project/data/repo/auth/general_setting_repo.dart';
import 'package:base_project/data/repo/splash/splash_repo.dart';
import 'package:base_project/data/services/api_service.dart';



Future<Map<String, Map<String, String>>> init()async{
  final sharedPreferences=await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences, fenix: true);
  Get.lazyPut(() => ApiClient(sharedPreferences: Get.find()));
  Get.lazyPut(() => GeneralSettingRepo(apiClient: Get.find()));
  Get.lazyPut(() => SplashRepo(apiClient: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(repo:Get.find(),localizationController: Get.find()));
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));

  Map<String,Map<String,String>> language = {};
  language['en_US'] = {'':''};

  return language;

}