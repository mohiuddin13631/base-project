import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:base_project/core/route/route.dart';
import 'package:base_project/core/utils/my_strings.dart';
import 'package:base_project/data/model/user/user.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../views/components/snackbar/show_custom_snackbar.dart';
import '../../model/auth/login_response_model.dart';
import '../../model/general_setting/general_settings_response_model.dart';
import '../../model/global/response_model/response_model.dart';
import '../../repo/auth/social_login_repo.dart';

class SocialLoginController extends GetxController {

  SocialLoginRepo repo;
  SocialLoginController({required this.repo});
 

  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool isGoogleSignInLoading = false;
  Future<void> signInWithGoogle() async {
    try {
      isGoogleSignInLoading = true;
      update();
      googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        isGoogleSignInLoading = false;
        update();
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      await socialLoginUser(provider: 'google', accessToken: googleAuth.accessToken ?? '');
    } catch (e) {
      debugPrint(e.toString());
      CustomSnackBar.error(errorList: [e.toString()]);
    }

    isGoogleSignInLoading = false;
    update();
  }

  Future socialLoginUser({
    String accessToken = '',
    String? provider,
  }) async {
    try {
      ResponseModel responseModel = await repo.socialLoginUser(
        accessToken: accessToken,
        provider: provider,
      );
      if (responseModel.statusCode == 200) {
        LoginResponseModel loginModel = LoginResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        if (loginModel.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
          String accessToken = loginModel.data?.accessToken ?? "";
          String tokenType = loginModel.data?.tokenType ?? "";
          User? user = loginModel.data?.user;
          await RouteHelper.checkUserStatusAndGoToNextStep(user,accessToken: accessToken,tokenType: tokenType,isRemember: true);
        } else {
          CustomSnackBar.error(errorList: loginModel.message?.error ?? [MyStrings.loginFailedTryAgain.tr]);
        }
      } else {
        CustomSnackBar.error(errorList: [responseModel.message]);
      }
    } catch (e) {
      //printx(e.toString());
    }
  }

  bool checkSocialAuthActiveOrNot({String provider = 'all'}) {

    if (provider == 'google') {
      return repo.apiClient.getSocialCredentialsConfigData().google?.status == '1';
    } else if (provider == 'facebook') {
      return repo.apiClient.getSocialCredentialsConfigData().facebook?.status == '1';
    } else if (provider == 'linkedin') {
      return repo.apiClient.getSocialCredentialsConfigData().linkedin?.status == '1';
    } else {
      return repo.apiClient.isSocialAnyOfSocialLoginOptionEnable();
    }
  }
}