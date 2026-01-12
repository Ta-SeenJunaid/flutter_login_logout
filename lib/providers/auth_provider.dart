import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';
import '../core/api/auth_api.dart';
import '../core/storage/secure_token_storage.dart';
import '../models/user_role.dart';

final authServiceProvider = Provider(
  (_) => AuthService(AuthApi(), SecureTokenStorage()),
);

class AuthState {
  final bool loggedIn;
  final UserRole? role;

  AuthState(this.loggedIn, this.role);
}

final authProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<AuthState>>(
  (ref) => AuthNotifier(ref),
);

class AuthNotifier extends StateNotifier<AsyncValue<AuthState>> {
  AuthNotifier(this.ref) : super(const AsyncLoading()) {
    _init();
  }

  final Ref ref;

  Future<void> _init() async {
    final service = ref.read(authServiceProvider);
    state = AsyncData(
      AuthState(await service.isLoggedIn(), await service.role()),
    );
  }

  Future<void> login(String u, String p) async {
    state = const AsyncLoading();
    await ref.read(authServiceProvider).login(u, p);
    state = AsyncData(
      AuthState(true, await ref.read(authServiceProvider).role()),
    );
  }

  Future<void> logout() async {
    await ref.read(authServiceProvider).logout();
    state = AsyncData(AuthState(false, null));
  }
}
