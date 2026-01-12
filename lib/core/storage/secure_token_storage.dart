import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureTokenStorage {
  final _storage = const FlutterSecureStorage();

  static const _access = 'access';
  static const _refresh = 'refresh';
  static const _role = 'role';

  Future<void> save({
    required String access,
    required String refresh,
    required String role,
  }) async {
    await _storage.write(key: _access, value: access);
    await _storage.write(key: _refresh, value: refresh);
    await _storage.write(key: _role, value: role);
  }

  Future<String?> access() => _storage.read(key: _access);
  Future<String?> refresh() => _storage.read(key: _refresh);
  Future<String?> role() => _storage.read(key: _role);

  Future<void> clear() => _storage.deleteAll();
}
