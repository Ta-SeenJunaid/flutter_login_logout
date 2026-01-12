import '../core/api/auth_api.dart';
import '../core/storage/token_storage.dart';

class AuthService {
  AuthService(this._api, this._storage);

  final AuthApi _api;
  final TokenStorage _storage;

  Future<String?> login(String username, String password) async {
    final response = await _api.login(username, password);

    if (response.accessToken.isNotEmpty) {
      await _storage.save(response.accessToken);
      return null;
    }

    return response.errorMessage;
  }

  Future<void> logout() async {
    await _storage.clear();
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read();
    return token != null && token.isNotEmpty;
  }
}
