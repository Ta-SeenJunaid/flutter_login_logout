import 'package:dio/dio.dart';
import '../storage/secure_token_storage.dart';
import 'auth_api.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.storage, this.api);

  final SecureTokenStorage storage;
  final AuthApi api;

  bool _isRefreshing = false;

  @override
  Future<void> onRequest(options, handler) async {
    final token = await storage.access();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, handler) async {
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;

      try {
        final refresh = await storage.refresh();
        if (refresh == null) throw Exception();

        final result = await api.refresh(refresh);
        await storage.save(
          access: result['access'],
          refresh: refresh,
          role: (await storage.role())!,
        );

        err.requestOptions.headers['Authorization'] =
            'Bearer ${result['access']}';

        _isRefreshing = false;
        return handler.resolve(
          await Dio().fetch(err.requestOptions),
        );
      } catch (_) {
        _isRefreshing = false;
        await storage.clear();
      }
    }

    handler.next(err);
  }
}
