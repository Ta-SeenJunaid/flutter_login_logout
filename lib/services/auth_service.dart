import '../core/api/auth_api.dart';
import '../core/storage/secure_token_storage.dart';
import '../models/user_role.dart';

class AuthService {
  AuthService(this.api, this.storage);

  final AuthApi api;
  final SecureTokenStorage storage;

  Future<void> login(String u, String p) async {
    final res = await api.login(u, p);

    await storage.save(
      access: res['access'],
      refresh: res['refresh'],
      role: res['role'],
    );
  }

  Future<void> logout() => storage.clear();

  Future<bool> isLoggedIn() async =>
      (await storage.access()) != null;

  Future<UserRole?> role() async {
    final r = await storage.role();
    return r == null ? null : UserRole.values.byName(r);
  }
}
