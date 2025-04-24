import 'package:flutter/material.dart';

class TrapStatusScreen extends StatelessWidget {
  const TrapStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This value is hardcoded for now.
    // In the future, it could come from Firestore, a sensor, or a backend.
    final String trapStatus = 'active'; // Placeholder for trap status

    return Scaffold(
      appBar: AppBar(title: const Text('Trap Status')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              trapStatus == 'active'
                  ? Icons.check_circle_outline
                  : Icons.warning_amber_rounded,
              size: 100,
              color: trapStatus == 'active' ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 24),
            Text(
              trapStatus == 'active'
                  ? 'The trap is active and ready!'
                  : 'The trap is not active yet.',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
