import '../../models/user_role.dart';

class AuthApi {
  Future<Map<String, dynamic>> login(String user, String pass) async {
    await Future.delayed(const Duration(seconds: 1));

    if (pass != '1234') {
      throw Exception('Invalid credentials');
    }

    return {
      'access': 'access_${DateTime.now().millisecondsSinceEpoch}',
      'refresh': 'refresh_token',
      'role': user == 'admin' ? UserRole.admin.name : UserRole.user.name,
    };
  }

  Future<Map<String, dynamic>> refresh(String refreshToken) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (refreshToken.isEmpty) {
      throw Exception('Refresh expired');
    }

    return {'access': 'refreshed_${DateTime.now().millisecondsSinceEpoch}'};
  }
}
