import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserSettingsScreen extends StatelessWidget {
  const UserSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Account Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('Email: ${user?.email ?? "Unknown"}'),
            const SizedBox(height: 32),
            const Text('Account Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.lock_reset),
              label: const Text('Reset Password'),
              onPressed: () {
                FirebaseAuth.instance.sendPasswordResetEmail(email: user!.email!);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Password reset email sent.')),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('Sign Out'),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.delete_forever),
              label: const Text('Delete Account'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Account'),
                    content: const Text('Are you sure you want to delete your account? This cannot be undone.'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                      TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete')),
                    ],
                  ),
                );

                if (confirm == true) {
                  try {
                    await user?.delete();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Account deleted successfully.')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to delete account: $e')),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
