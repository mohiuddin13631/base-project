import 'package:base_project/core/utils/method.dart';
import 'package:base_project/core/utils/url.dart';
import 'package:base_project/data/model/global/response_model/response_model.dart';
import 'package:base_project/data/services/api_service.dart';

class ReferralRepo{
  ApiClient apiClient;
  ReferralRepo({required this.apiClient});

  Future<ResponseModel> getReferralData(int page, {String searchText = ""})async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.referralEndPoint}?page=$page&search=$searchText";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }
}