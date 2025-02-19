import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:base_project/core/helper/shared_preference_helper.dart';
import 'package:base_project/core/utils/method.dart';
import 'package:base_project/core/utils/url.dart';
import 'package:base_project/data/model/auth/sign_up_model/sign_up_model.dart';
import 'package:base_project/data/model/global/response_model/response_model.dart';
import 'package:base_project/data/services/api_service.dart';

class RegistrationRepo {
  ApiClient apiClient;

  RegistrationRepo({required this.apiClient});

  Future<ResponseModel> registerUser(SignUpModel model) async {
    final map = model.toMap();
    String url ='${UrlContainer.baseUrl}${UrlContainer.registrationEndPoint}';
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, map,passHeader: true,isOnlyAcceptType: true);
    return responseModel;
  }

}