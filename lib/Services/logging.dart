import 'package:dio/dio.dart';


import '../Utli/Constatns.dart';

class Logging extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {

    ErrorMsg =  'ERROR[${err.response?.statusCode}] => PATH: ${err.message}';
    print(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.message}',
    );

    return super.onError(err, handler);
  }
}
