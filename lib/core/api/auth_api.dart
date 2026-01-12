import '../../models/login_response.dart';

class AuthApi {
  Future<LoginResponse> login(String userName, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (userName == 'admin' && password == '1234') {
      return LoginResponse(
        accessToken: 'dummy_access_token',
        refreshToken: 'dummy_refresh_token',
        tokenType: 'Bearer',
        expiresIn: 3600,
      );
    }

    return LoginResponse(
      accessToken: '',
      refreshToken: '',
      tokenType: '',
      expiresIn: 0,
      errorMessage: 'Invalid credentials',
    );
  }
}
