import 'package:dio/dio.dart';
import 'package:todoist/utils/app_urls.dart';

class DioService{
  static Dio dio = Dio();

  void setupDio(){
    dio.options = BaseOptions(
      baseUrl: AppUrls.baseUrl,
      
      headers: {
        'Authorization' : "Bearer ${AppUrls.apiToken}",
        "Content-Type" : "application/json",
        "Accept" : "application/json"
      },

      connectTimeout: const Duration(seconds: 5000),
      receiveTimeout: const Duration(seconds: 3000),
      responseType: ResponseType.json,
    );
  }
}