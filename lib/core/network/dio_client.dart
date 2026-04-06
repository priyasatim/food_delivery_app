import 'package:dio/dio.dart';

class DioClient {
  static Dio getMainDio() {
    return Dio(
      BaseOptions(
        baseUrl: "https://api.main.com",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    )..interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  static Dio getAuthDio() {
    return Dio(
      BaseOptions(
        baseUrl: "https://auth.main.com",
      ),
    );
  }

  static Dio getPaymentDio() {
    return Dio(
      BaseOptions(
        baseUrl: "https://payment.main.com",
      ),
    );
  }
}