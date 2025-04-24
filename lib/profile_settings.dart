import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = user?.displayName ?? '';
  }

  void _changePassword() {
    if (user != null && user!.email != null) {
      FirebaseAuth.instance.sendPasswordResetEmail(email: user!.email!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent.')),
      );
    }
  }

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _deleteAccount() async {
    try {
      await user?.delete();
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  void _updateDisplayName() async {
    final newName = _nameController.text.trim();
    if (newName.isNotEmpty) {
      await user?.updateDisplayName(newName);
      await user?.reload(); // refresh user info
      setState(() {}); // update UI
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Display name updated!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Settings")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Edit your profile info",
                style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
            const SizedBox(height: 24),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Display Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text("Save Name"),
              onPressed: _updateDisplayName,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.lock_reset),
              label: const Text("Change Password"),
              onPressed: _changePassword,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text("Sign Out"),
              onPressed: _signOut,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.delete_forever),
              label: const Text("Delete Account"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: _deleteAccount,
            ),
          ],
        ),
      ),
    );
  }
}
