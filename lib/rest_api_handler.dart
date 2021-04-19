import 'api_response_converter.dart';
import 'network_config.dart';
import 'package:dio/dio.dart';

class ApiResponse {
  Status status;
  Map<String, dynamic>? data;
  String? message;

  ApiResponse.completed(this.message, this.data) : status = Status.COMPLETED;
  ApiResponse.error(this.message, this.data) : status = Status.ERROR;
  ApiResponse.unhandledError(this.message) : status = Status.ERROR;
}

enum Status { COMPLETED, ERROR }

class ApiBaseHelper {
  Future<ApiResponse> get(String url, {queryParameters = null}) async {
    var responseJson;
    try {
      Response response = await NetworkConfiguration.instance.dio.get(url,
          queryParameters: queryParameters,
          options: _getResponseReturnOption());
      responseJson = _returnResponse(response);
    } catch (ex) {
      return manageException(ex);
    }
    return responseJson;
  }

  Future<ApiResponse> post(String url, request, {isPutMethod = false}) async {
    var responseJson;
    try {
      Response response;
      if (!isPutMethod)
        response = await NetworkConfiguration.instance.dio
            .post(url, data: request, options: _getResponseReturnOption());
      else
        response = await NetworkConfiguration.instance.dio
            .put(url, data: request, options: _getResponseReturnOption());

      responseJson = _returnResponse(response);
    } catch (ex) {
      return manageException(ex);
    }
    return responseJson;
  }

  manageException(ex) {
    var errorMessage = 'something_went_wrong';
    try {
      if (DioErrorType.connectTimeout == ex.type ||
          DioErrorType.sendTimeout == ex.type ||
          DioErrorType.receiveTimeout == ex.type)
        errorMessage = "Connection timeout. Try again later";
      else if (DioErrorType.other == ex.type) {
        if (ex.message.contains('SocketException'))
          errorMessage = 'network_error_message';
      }
    } catch (ex) {
      print(ex.toString());
    }

    return ApiResponse.unhandledError(errorMessage);
  }

  _getResponseReturnOption() {
    return Options(
        followRedirects: false,
        validateStatus: (status) {
          return true;
        });
  }

  ApiResponse _returnResponse(Response response) {
    BaseResponse baseResponse;
    try {
      baseResponse = BaseResponse.fromJson(response.data);
    } catch (ex) {
      return manageException(ex);
    }
    switch (response.statusCode) {
      case 200:
        return ApiResponse.completed(
            baseResponse.message, response.data['data']);
      case 401:
        return ApiResponse.error(baseResponse.message, response.data);
        break;

      case 400:
      case 403:
      case 404:
      case 500:
      default:
        return ApiResponse.error(baseResponse.message, response.data);
    }
  }
}
