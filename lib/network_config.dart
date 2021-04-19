import 'package:dio/dio.dart';

class NetworkConfiguration {
  Dio dio = Dio();
  static final NetworkConfiguration _instance =
      NetworkConfiguration._internal();

  static NetworkConfiguration get instance => NetworkConfiguration();

  NetworkConfiguration._internal() {
    initConfig();
  }

  factory NetworkConfiguration() {
    return _instance;
  }

  initConfig() {
    BaseOptions options = BaseOptions(
      baseUrl: 'url',
      receiveTimeout: 50000,
      connectTimeout: 30000,
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
      headers: {'content-type':'application/json'}
    );
    dio = Dio(options);
    dio.interceptors.add(LogInterceptor(
        requestBody: true, responseBody: true, requestHeader: true));
  }
}
