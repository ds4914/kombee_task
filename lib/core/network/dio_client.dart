import 'package:dio/dio.dart';
import 'package:kombee_task/core/constants/network_urls.dart';

class DioClient {
  final Dio _dio = Dio(
      BaseOptions(
        baseUrl: NetworkUrls.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    )
    ..interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        logPrint: print,
      ),
    );

  Dio get dio => _dio;
}
