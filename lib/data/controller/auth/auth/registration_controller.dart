import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base_project/core/helper/shared_preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:base_project/core/utils/my_strings.dart';
import 'package:base_project/core/route/route.dart';
import 'package:base_project/data/model/auth/error_model.dart';
import 'package:base_project/data/model/auth/registration_response_model.dart';
import 'package:base_project/data/model/auth/sign_up_model/sign_up_model.dart';
import 'package:base_project/data/model/country_model/country_model.dart';
import 'package:base_project/data/model/general_setting/general_settings_response_model.dart';
import 'package:base_project/data/model/global/response_model/response_model.dart';
import 'package:base_project/data/repo/auth/general_setting_repo.dart';
import 'package:base_project/data/repo/auth/signup_repo.dart';
import 'package:base_project/views/components/snackbar/show_custom_snackbar.dart';

class RegistrationController extends GetxController {
  RegistrationRepo registrationRepo;
  GeneralSettingRepo generalSettingRepo;

  RegistrationController({required this.registrationRepo, required this.generalSettingRepo});

  bool isLoading = true;
  bool agreeTC = false;

  GeneralSettingsResponseModel generalSettingMainModel =
  GeneralSettingsResponseModel();

  //it will come from general setting api
  bool checkPasswordStrength = false;
  bool needAgree=true;

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode countryNameFocusNode = FocusNode();
  final FocusNode mobileFocusNode = FocusNode();
  final FocusNode userNameFocusNode = FocusNode();
  final FocusNode referralCodeFocusNode = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController referralCodeController = TextEditingController();


  String? email;
  String? password;
  String? confirmPassword;
  String? countryName;
  String? countryCode;
  String? mobileCode;
  String? userName;
  String? phoneNo;
  String? firstName;
  String? lastName;

  RegExp regex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  bool submitLoading=false;
  signUpUser() async {

    if (needAgree && !agreeTC) {
      CustomSnackBar.error(
        errorList: [MyStrings.agreePolicyMessage],
      );
      return;
    }

    submitLoading=true;
    update();

    SignUpModel model = getUserData();
    ResponseModel responseModel = await registrationRepo.registerUser(model);

    if (responseModel.statusCode == 200) {
      RegistrationResponseModel model = RegistrationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        CustomSnackBar.success(successList: model.message?.success ?? [MyStrings.success.tr]);
        checkAndGotoNextStep(model);
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong.tr]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    submitLoading = false;
    update();
  }


  updateAgreeTC() {
    agreeTC = !agreeTC;
    update();
  }

  SignUpModel getUserData() {

    String referenceValue = referralCodeController.text.toString().split('=').last;

    SignUpModel model = SignUpModel(
      firstName: fNameController.text.toString(),
      lastName: lNameController.text.toString(),
      email: emailController.text.toString(),
      password: passwordController.text.toString(),
      refference: referenceValue.toString(),
      agree: agreeTC ? true : false,
    );

    return model;
  }


  void checkAndGotoNextStep(RegistrationResponseModel responseModel) async {

    SharedPreferences preferences = registrationRepo.apiClient.sharedPreferences;

    await preferences.setString(SharedPreferenceHelper.userIdKey, responseModel.data?.user?.id.toString() ?? '-1');
    await preferences.setString(SharedPreferenceHelper.accessTokenKey, responseModel.data?.accessToken ?? '');
    await preferences.setString(SharedPreferenceHelper.accessTokenType, responseModel.data?.tokenType ?? '');
    await preferences.setString(SharedPreferenceHelper.userEmailKey, responseModel.data?.user?.email ?? '');
    await preferences.setString(SharedPreferenceHelper.userNameKey, responseModel.data?.user?.username ?? '');
    await preferences.setString(SharedPreferenceHelper.userPhoneNumberKey, responseModel.data?.user?.mobile ?? '');

    Get.offAndToNamed(RouteHelper.profileCompleteScreen);

  }

  void closeAllController() {
    isLoading = false;
    emailController.text = '';
    passwordController.text = '';
    cPasswordController.text = '';
    fNameController.text = '';
    lNameController.text = '';
  }

  clearAllData() {
    closeAllController();
  }

  List<ErrorModel> passwordValidationRules = [
    ErrorModel(text: MyStrings.hasUpperLetter.tr, hasError: true),
    ErrorModel(text: MyStrings.hasLowerLetter.tr, hasError: true),
    ErrorModel(text: MyStrings.hasDigit.tr, hasError: true),
    ErrorModel(text: MyStrings.hasSpecialChar.tr, hasError: true),
    ErrorModel(text: MyStrings.minSixChar.tr, hasError: true),
  ];

  bool isCountryLoading=true;
  void initData() async {

    isLoading = true;
    update();

    ResponseModel response = await generalSettingRepo.getGeneralSetting();
    if(response.statusCode==200){
      GeneralSettingsResponseModel model =
      GeneralSettingsResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase()=='success') {
        generalSettingMainModel =model;
        registrationRepo.apiClient.storeGeneralSetting(model);
      } else {
        List<String>message=[MyStrings.somethingWentWrong.tr];
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

    needAgree = generalSettingMainModel.data?.generalSetting?.agree.toString() == '0' ? false : true;
    checkPasswordStrength = generalSettingMainModel.data?.generalSetting?.securePassword.toString() == '0' ? false : true;

    isLoading = false;
    update();
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return MyStrings.enterYourPassword_.tr;
    } else {
      if (checkPasswordStrength) {
        if (!regex.hasMatch(value)) {
          return MyStrings.invalidPassMsg.tr;
        } else {
          return null;
        }
      } else {
        return null;
      }
    }
  }

  bool noInternet = false;
  void changeInternet(bool hasInternet) {
    noInternet = false;
    initData();
    update();
  }

  void updateValidationList(String value) {
    passwordValidationRules[0].hasError = value.contains(RegExp(r'[A-Z]')) ? false : true;
    passwordValidationRules[1].hasError = value.contains(RegExp(r'[a-z]')) ? false : true;
    passwordValidationRules[2].hasError = value.contains(RegExp(r'[0-9]')) ? false : true;
    passwordValidationRules[3].hasError = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ? false : true;
    passwordValidationRules[4].hasError = value.length >= 6 ? false : true;

    update();
  }

  bool hasPasswordFocus = false;
  void changePasswordFocus(bool hasFocus) {
    hasPasswordFocus = hasFocus;
    update();
  }

}
