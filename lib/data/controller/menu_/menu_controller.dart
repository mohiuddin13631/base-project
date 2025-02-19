import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:base_project/core/helper/shared_preference_helper.dart';
import 'package:base_project/core/route/route.dart';
import 'package:base_project/core/utils/my_strings.dart';
import 'package:base_project/data/model/authorization/authorization_response_model.dart';
import 'package:base_project/data/model/general_setting/general_settings_response_model.dart';
import 'package:base_project/data/model/global/response_model/response_model.dart';
import 'package:base_project/data/repo/auth/general_setting_repo.dart';
import 'package:base_project/views/components/snackbar/show_custom_snackbar.dart';

class MyMenuController extends GetxController  {

  GeneralSettingRepo repo;
  bool isLoading = true;
  bool noInternet = false;

  bool balTransferEnable = true;
  bool langSwitchEnable = true;
  bool isDepositEnable = true;
  bool isWithdrawEnable = true;

  MyMenuController({required this.repo});

  void loadData()async{
    GeneralSettingsResponseModel model = repo.apiClient.getGSData();
    isDepositEnable = model.data?.generalSetting?.modules?.deposit=='0'?false:true;
    isWithdrawEnable = model.data?.generalSetting?.modules?.withdraw=='0'?false:true;
    isLoading = true;
    update();
    await configureMenuItem();
    isLoading = false;
    update();
  }

  configureMenuItem()async{

    ResponseModel response = await repo.getGeneralSetting();

    if(response.statusCode==200){
      GeneralSettingsResponseModel model =
      GeneralSettingsResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase()==MyStrings.success.toLowerCase()) {
        bool langStatus = true;
        langSwitchEnable = langStatus;
        repo.apiClient.storeGeneralSetting(model);
        update();
      }
      else {
        List<String>message=[MyStrings.somethingWentWrong];
        CustomSnackBar.error(errorList:model.message?.error??message);
        return;
      }
    }else{
      if(response.statusCode==503){
        noInternet=true;
        update();
      }
      CustomSnackBar.error(errorList:[response.message]);
      return;
    }
  }

  bool logoutLoading = false;
  Future<void>logout()async{
    List<String>msg = [];
    logoutLoading = true;
    update();
    try{
      ResponseModel response = await repo.logout();
      if(response.statusCode == 200){
        AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
        if(model.status?.toLowerCase() == MyStrings.success.toLowerCase() || model.status?.toLowerCase() == 'ok'){
          msg.addAll(model.message?.success??[MyStrings.logoutSuccessMsg]);
        } else{
          msg.add(MyStrings.logoutSuccessMsg);
        }
      }
      else{
        msg.add(MyStrings.logoutSuccessMsg);
      }
    } catch(e){
      if(kDebugMode){
        print(e.toString());
      }
    }

    logoutLoading = false;
    update();
    repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenKey, '');
    repo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
    Get.offAllNamed(RouteHelper.loginScreen);
    CustomSnackBar.success(successList: msg);
  }

  bool removeLoading = false;
  Future<void> removeAccount() async {
    removeLoading = true;
    update();

    final responseModal = await repo.removeAccount();
    if (responseModal.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModal.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success) {
        await repo.clearSharedPrefData();
        Get.offAllNamed(RouteHelper.loginScreen);
        CustomSnackBar.success(successList: model.message?.success ?? [MyStrings.accountDeletedSuccessfully]);
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModal.message]);
    }


    removeLoading = false;
    update();
  }

}