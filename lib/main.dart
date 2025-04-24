import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'trap_status_screen.dart';
import 'drop_off_locations_screen.dart';
import 'trap_activity_log.dart';
import 'technical_issues.dart';
import 'profile_settings.dart'; // ✅ Custom user profile screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrapSync',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/flutterfire_300x.png', height: 180),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => SignInScreen(
                        providers: [EmailAuthProvider()],
                        showAuthActionSwitch: false,
                        actions: [
                          AuthStateChangeAction<SignedIn>((context, state) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_) => const HomeScreen()),
                            );
                          }),
                        ],
                      ),
                    ));
                  },
                  child: const Text('Log In'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[300],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => RegisterScreen(
                        providers: [EmailAuthProvider()],
                        actions: [
                          AuthStateChangeAction<SignedIn>((context, state) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_) => const HomeScreen()),
                            );
                          }),
                        ],
                      ),
                    ));
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Future.microtask(() {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const WelcomeScreen()),
        );
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileSettingsScreen()), // ✅ Updated
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/flutterfire_300x.png', height: 150),
            const SizedBox(height: 24),
            Text(
              'Welcome, ${user.displayName ?? 'User'}!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            const SignOutButton(),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.visibility),
              label: const Text('View Trap Status'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TrapStatusScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.map_outlined),
              label: const Text('View Drop-off Locations'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DropOffLocationsScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.list_alt_outlined),
              label: const Text('View Trap Activity Log'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TrapActivityLogScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.warning_amber_outlined),
              label: const Text('Trap Technical Support'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TechnicalIssuesScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

