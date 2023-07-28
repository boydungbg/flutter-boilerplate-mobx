import 'package:dio/dio.dart';

Dio registerResClient() {
  Dio dio =
      Dio(BaseOptions(baseUrl: 'https://645ba40ca8f9e4d6e76e9095.mockapi.io/'));

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, RequestInterceptorHandler handler) {
      print('REQUEST[${options.method}] => PATH: ${options.path}');
      return handler.next(options);
      //401
    },
    onResponse: (response, ResponseInterceptorHandler handler) {
      print(
          'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
      return handler.next(response);
    },
    onError: (err, handler) {
      print(
          'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
      //When error is 401 for login page
    },
  ));

  return dio;
}
