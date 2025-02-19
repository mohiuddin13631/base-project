import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:base_project/core/route/route.dart';
import 'package:base_project/core/utils/my_strings.dart';
import 'package:base_project/data/model/authorization/authorization_response_model.dart';
import 'package:base_project/data/model/global/response_model/response_model.dart';
import 'package:base_project/data/repo/auth/sms_email_verification_repo.dart';
import 'package:base_project/views/components/snackbar/show_custom_snackbar.dart';

import '../../../services/push_notification_service.dart';

class EmailVerificationController extends GetxController {


  SmsEmailVerificationRepo repo;

  EmailVerificationController({required this.repo});

  String currentText = "";
  bool needTwoFactor = false;
  bool submitLoading = false;
  bool isLoading = true;
  bool resendLoading = false;

  loadData() async {
    isLoading = true;
    update();

    ResponseModel responseModel = await repo.sendAuthorizationRequest();

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status == 'error') {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    isLoading = false;
    update();
  }


  Future<void> verifyEmail(String text) async {
    if (text.isEmpty) {
      CustomSnackBar.error(errorList: [MyStrings.otpFieldEmptyMsg]);
      return;
    }

    submitLoading = true;
    update();

    ResponseModel responseModel = await repo.verify(text);

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      bool isSMSVerificationEnable = model.data?.user?.sv == "0" ? true : false;
      bool is2FAEnable = model.data?.user?.tv == "0" ? true : false;

      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        if (isSMSVerificationEnable) {
          Get.offAndToNamed(RouteHelper.smsVerificationScreen);
        } else if (is2FAEnable) {
          Get.offAndToNamed(RouteHelper.twoFactorScreen);
        } else {
          PushNotificationService(apiClient: Get.find()).sendUserToken();
          Get.offAndToNamed(RouteHelper.bottomNavBar);
        }
        CustomSnackBar.success(successList: model.message?.success ?? [(MyStrings.emailVerificationSuccess)]);
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [(MyStrings.emailVerificationFailed)]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    submitLoading = false;
    update();
  }

  Future<void> sendCodeAgain() async {
    resendLoading = true;
    update();
    await repo.resendVerifyCode(isEmail: true);
    resendLoading = false;
    update();
  }
}
