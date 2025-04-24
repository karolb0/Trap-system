import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_state.dart';

class LoggedOutView extends StatefulWidget {
  final AppState state;
  const LoggedOutView({super.key, required this.state});

  @override
  State<LoggedOutView> createState() => _LoggedOutViewState();
}

class _LoggedOutViewState extends State<LoggedOutView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trap Sync!')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/TrapSyncLogo-01.png',
                height: 120, // adjust size as needed
              ),
              const SizedBox(height: 24),
              Text(
                'Please log in',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              if (_error != null) ...[
                const SizedBox(height: 8),
                Text(_error!, style: const TextStyle(color: Colors.red)),
              ],
              const SizedBox(height: 16),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.blue, // <- Your custom color
                  foregroundColor: Colors.white, // <- Text color
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () async {
                  final email = _emailController.text;
                  final password = _passwordController.text;

                  try {
                    await widget.state.logIn(email, password);
                    if (widget.state.user != null && context.mounted) {
                      context.go('/');
                    }
                  } catch (e) {
                    setState(() {
                      _error = 'Login failed. Please check your credentials.';
                    });
                  }
                },
                child: const Text('Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}