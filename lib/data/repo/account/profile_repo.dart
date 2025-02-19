import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:base_project/core/utils/method.dart';
import 'package:base_project/core/utils/my_strings.dart';
import 'package:base_project/core/utils/url.dart';
import 'package:base_project/data/model/authorization/authorization_response_model.dart';
import 'package:base_project/data/model/global/response_model/response_model.dart';
import 'package:base_project/data/model/profile_complete/profile_complete_response_model.dart';
import 'package:base_project/data/model/user/user.dart';
import 'package:base_project/data/model/user_post_model/user_post_model.dart';
import 'package:base_project/data/services/api_service.dart';
import 'package:base_project/data/services/push_notification_service.dart';
import 'package:base_project/views/components/snackbar/show_custom_snackbar.dart';
import '../../../core/helper/shared_preference_helper.dart';
import '../../../core/route/route.dart';
import '../../model/profile_complete/profile_complete_post_model.dart';

class ProfileRepo {

  ApiClient apiClient;
  ProfileRepo({required this.apiClient});

  Future<bool> updateProfile(ProfilePostModel  model,bool isProfile) async {
    try{
      apiClient.initToken();

      String url = '${UrlContainer.baseUrl}${isProfile?UrlContainer.updateProfileEndPoint:UrlContainer.profileCompleteEndPoint}';

      var request=http.MultipartRequest('POST',Uri.parse(url));

      Map<String,String>finalMap={
        'firstname': model.firstname,
        'lastname': model.lastName,
        'address': model.address??'',
        'zip': model.zip??'',
        'state': model.state??"",
        'city': model.city??'',
      };

      request.headers.addAll(<String,String>{'Authorization' : 'Bearer ${apiClient.token}'});
      if(model.image!=null){
        request.files.add( http.MultipartFile('image', model.image!.readAsBytes().asStream(), model.image!.lengthSync(), filename: model.image!.path.split('/').last));
      }
      request.fields.addAll(finalMap);

      http.StreamedResponse response = await request.send();

      String jsonResponse=await response.stream.bytesToString();
      AuthorizationResponseModel authorizationResponseModel = AuthorizationResponseModel.fromJson(jsonDecode(jsonResponse));

      if(authorizationResponseModel.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        CustomSnackBar.success(successList: authorizationResponseModel.message?.success??[MyStrings.success]);
        return true;
      }else{
        CustomSnackBar.error(errorList: authorizationResponseModel.message?.error??[MyStrings.requestFail.tr]);
        return false;
      }

    }catch(e){
      return false;
    }

  }

  Future<void> completeProfile(ProfileCompletePostModel model) async {
    try{
      apiClient.initToken();

      String url = '${UrlContainer.baseUrl}${UrlContainer.profileCompleteEndPoint}';

      var request=http.MultipartRequest('POST',Uri.parse(url));

      Map<String,String>finalMap={
        'username': model.username,
        'country': model.countryName,
        'country_code': model.countryCode,
        'mobile': model.mobileNumber,
        'mobile_code': model.mobileCode,
        'address': model.address??'',
        'zip': model.zip??'',
        'state': model.state??"",
        'city': model.city??'',
      };

      request.headers.addAll(<String,String>{'Authorization' : 'Bearer ${apiClient.token}'});
      if(model.image!=null){
        request.files.add( http.MultipartFile('image', model.image!.readAsBytes().asStream(), model.image!.lengthSync(), filename: model.image!.path.split('/').last));
      }
      request.fields.addAll(finalMap);

      http.StreamedResponse response = await request.send();

      String jsonResponse=await response.stream.bytesToString();
      ProfileCompleteResponseModel profileCompleteResponseModel = ProfileCompleteResponseModel.fromJson(jsonDecode(jsonResponse));

      if(profileCompleteResponseModel.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        checkAndGotoNextStep(profileCompleteResponseModel.data?.user);
        CustomSnackBar.success(successList: profileCompleteResponseModel.message?.success??[MyStrings.success]);
        // return true;
      }else{
        CustomSnackBar.error(errorList: profileCompleteResponseModel.message?.error??[MyStrings.requestFail.tr]);
      }

    }catch(e){
      print(e);
    }

  }


/*  Future<ResponseModel> completeProfile(ProfileCompletePostModel model, File? image) async {

    dynamic params = model.toMap();
    String url = '${UrlContainer.baseUrl}${UrlContainer.profileCompleteEndPoint}';
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, params, passHeader: true);
    return responseModel;
  }*/

  Future<ResponseModel> loadProfileInfo() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.getProfileEndPoint}';
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<void>updateDeviceToken() async{
    await PushNotificationService(apiClient: Get.find()).sendUserToken();
  }

  Future<dynamic>getCountryList()async{
    String url = '${UrlContainer.baseUrl}${UrlContainer.countryEndPoint}';
    ResponseModel model=await apiClient.request(url, Method.getMethod, null);
    return model;
  }


  void checkAndGotoNextStep(User? user) async {
    bool needEmailVerification = user?.ev == "1" ? false : true;
    bool needSmsVerification = user?.sv == '1' ? false : true;
    bool isTwoFactorEnable = user?.tv == '1' ? false : true;

    await apiClient.sharedPreferences.setString(SharedPreferenceHelper.userIdKey, user?.id.toString() ?? '-1');
    await apiClient.sharedPreferences.setString(SharedPreferenceHelper.userEmailKey, user?.email ?? '');
    await apiClient.sharedPreferences.setString(SharedPreferenceHelper.userPhoneNumberKey, user?.mobile ?? '');
    await apiClient.sharedPreferences.setString(SharedPreferenceHelper.userNameKey, user?.username ?? '');

    if (needEmailVerification) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen);
    } else if (needSmsVerification) {
      Get.offAndToNamed(RouteHelper.smsVerificationScreen);
    } else if (isTwoFactorEnable) {
      Get.offAndToNamed(RouteHelper.twoFactorScreen);
    } else {
      await updateDeviceToken();
      Get.offAndToNamed(RouteHelper.bottomNavBar);
    }
  }

}
