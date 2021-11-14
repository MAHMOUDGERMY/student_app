import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData(
      {required String url,
      Map<String, dynamic>? query,
      String lang = "en",
      String? token}) async {
    dio!.options.headers = {
      "Content-Type": "application/json",
      "Authorization": token ?? '',
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      {String? url, required Map<String, dynamic> data, String? token}) async {
    dio!.options.headers = {
      "Content-Type": "application/json",
      "Authorization":
          "key=AAAAX3xyBcE:APA91bEvEozUyCVYW2mLkB7FkC6l-VfHXCJcTcpDdl7Aiyly1_3b8tmrLqc_yLA2eVzRk8_jQfAIY-qd2P3In62Tqu6KsS12nbgq1J8gkUbzRu48jaPnSNCZIoijOQbZJAWYjYVhjOBm",
    };
    return dio!.post("https://fcm.googleapis.com/fcm/send", data: data);
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = "ar",
    String? token,
  }) async {
    dio!.options.headers = {
      "lang": lang,
      "Authorization": token ?? '',
      "Content-Type": "application/json",
    };
    return dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
