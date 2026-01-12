import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final userCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: userCtrl,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),

            authState.whenOrNull(
                  error: (e, _) => Text(
                    e.toString(),
                    style: const TextStyle(color: Colors.red),
                  ),
                ) ??
                const SizedBox(),

            ElevatedButton(
              onPressed: () {
                ref
                    .read(authStateProvider.notifier)
                    .login(userCtrl.text, passCtrl.text);
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
