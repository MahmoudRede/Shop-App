import 'package:dio/dio.dart' show BaseOptions, Dio, Response;

class DioHelper {
  static Dio? dio;

 static void init(){
    dio = Dio(
      BaseOptions(
        baseUrl:'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> geData({
    required String url,
    Map<String , dynamic>? query,
    String lang = 'en',
    String? token ,
  }) async{

    dio!.options.headers = {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization': token,
    };

    return await dio!.get(
      url,
      queryParameters: query,
    ).catchError((error) {
      print('error in getData Dio ${error.toString()}');
    });
  }

  static Future<Response> postData({
    required String url,
    Map<String , dynamic>? query,
    required Map<String , dynamic> data,
    String lang = 'en',
    String? token ,
  }) async{

    dio!.options.headers = {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization': token??'',
    };

    return await dio!.post(
      url,
      queryParameters: query,
      data: data,
    ).catchError((error) {
      print('error in getData Dio ${error.toString()}');
    });
  }

  static Future<Response> putData({
    required String url,
    Map<String , dynamic>? query,
    required Map<String , dynamic> data,
    String lang = 'ar',
    String? token ,
  }) async{

    dio!.options.headers = {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization': token??'',
    };

    return await dio!.put(
      url,
      queryParameters: query,
      data: data,
    ).catchError((error) {
      print('error in getData Dio ${error.toString()}');
    });
  }

}