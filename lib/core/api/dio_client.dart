import 'package:dio/dio.dart';
import '../storage/secure_token_storage.dart';
import 'auth_interceptor.dart';
import 'auth_api.dart';

Dio createDio() {
  final dio = Dio();
  dio.interceptors.add(
    AuthInterceptor(SecureTokenStorage(), AuthApi()),
  );
  return dio;
}
