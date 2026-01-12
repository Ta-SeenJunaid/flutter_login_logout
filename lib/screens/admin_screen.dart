import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // ⛔ block back button
      onPopInvoked: (_) {
        context.go('/'); // force redirect to home
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/'),
          ),
        ),
        body: const Center(
          child: Text('Admin Only'),
        ),
      ),
    );
  }
}
