import 'package:dio/dio.dart';
import 'package:svran_flutter_study/config/config.dart';
import 'package:svran_flutter_study/public_code.dart';

class HttpRequest {
  static final BaseOptions baseOptions = BaseOptions(
    baseUrl: HttpConfig.baseUrl,
    connectTimeout: HttpConfig.timeOut,
  );
  static final Dio dio = Dio(baseOptions);

  static Future<T> request<T>(
    String url, {
    String method = "get",
    Map<String, dynamic>? params,
    Interceptor? inter,
  }) async {
    // 创建个性化配置
    final options = Options();
    // 全局拦截器
    Interceptor dInter = InterceptorsWrapper(
      onRequest: (options, handler) {
        logger.i("Svran: Flutter -> 请求拦截 ${options.baseUrl} ${options.uri}");
        handler.next(options);
      },
      onResponse: (e, handler) {
        logger.i("Svran: Flutter -> 响应拦截");
        handler.next(e);
      },
      onError: (e, handler) {
        logger.i("Svran: Flutter -> 拦截 onError");
        handler.next(e);
      },
    );
    List<Interceptor> inters = [dInter];
    if (inter != null) inters.add(inter);
    dio.interceptors.addAll(inters);
    try {
      Response resp = await dio.request(url, queryParameters: params, options: options);
      return resp.data;
    } catch (e, s) {
      return Future.error(e, s);
    }
  }

  static void get() {}
}
