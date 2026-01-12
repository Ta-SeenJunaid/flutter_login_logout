import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/api/auth_api.dart';
import '../core/storage/token_storage.dart';
import '../services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(AuthApi(), TokenStorage());
});

final authStateProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<bool>>(
  (ref) => AuthNotifier(ref.read(authServiceProvider)),
);

class AuthNotifier extends StateNotifier<AsyncValue<bool>> {
  AuthNotifier(this._authService) : super(const AsyncLoading()) {
    _checkLogin();
  }

  final AuthService _authService;

  Future<void> _checkLogin() async {
    final loggedIn = await _authService.isLoggedIn();
    state = AsyncData(loggedIn);
  }

  Future<void> login(String username, String password) async {
    state = const AsyncLoading();

    final error = await _authService.login(username, password);
    if (error == null) {
      state = const AsyncData(true);
    } else {
      state = AsyncError(error, StackTrace.current);
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    state = const AsyncData(false);
  }
}
