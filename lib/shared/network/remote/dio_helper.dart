import 'package:dio/dio.dart';
//this for news app
// class DioHelper
// {
//   static late Dio dio;
//   static init()
//   {
//     dio=Dio(
//       BaseOptions(
//         baseUrl: 'https://newsapi.org/',
//
//         receiveDataWhenStatusError: true,
//       ),
//     );
//   }
//   static Future<Response> getData(String url,Map<String,dynamic> query) async
//   {
//     return await dio.get(url,queryParameters: query,);
//   }
//
//
//
// }

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {'Content-Type': 'application/json', 'lang': 'en'},
      ),
    );
  }

  static Future<Response> getData(
      String url,
  String token,


  Map<String, dynamic>? query ,{String lang = 'en',})
  async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token,
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postDate({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token,
    };

    return dio.post(url, queryParameters: query, data: data);
  }
  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token,
    };

    return dio.put(url, queryParameters: query, data: data);
  }
}
