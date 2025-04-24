import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('TrapSync'),
        actions: const [
          SignOutButton(), // Botón para cerrar sesión
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/TrapSyncLogo-01.png'),
                  const SizedBox(height: 32.0),
                  Text(
                    'Welcome, ${user?.email ?? "user"}!',
                    style: const TextStyle(fontSize: 20.0),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'You are now signed in.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

