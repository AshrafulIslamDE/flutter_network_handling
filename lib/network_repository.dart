
import 'package:flutter_api_handling/rest_api_handler.dart';

class SampleNetworkRepository{
  static var  helper=ApiBaseHelper();
  static Future<ApiResponse> get(request) async{
    ApiResponse response=await helper.post("/v1/customer/acceptBid",request);
    return response;
  }
}