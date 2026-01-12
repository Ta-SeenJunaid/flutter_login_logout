import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = TextEditingController();
    final pass = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: user, decoration: const InputDecoration(labelText: 'Username')),
            TextField(controller: pass, decoration: const InputDecoration(labelText: 'Password')),
            ElevatedButton(
              onPressed: () {
                ref.read(authProvider.notifier).login(
                      user.text,
                      pass.text,
                    );
              },
              child: const Text('Login'),
            ),
            const Text('admin / 1234 → admin\nuser / 1234 → user'),
          ],
        ),
      ),
    );
  }
}
