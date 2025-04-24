import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import 'entry.dart';

class AppState {
  AppState() {
    _entriesStreamController = StreamController.broadcast(
      onListen: () {
        _entriesStreamController.add([
          Entry(
            date: '10/09/2022',
            text: lorem,
            title: '[Example] My Journal Entry',
          ),
        ]);
      },
    );
  }

  User? user;
  late StreamController<List<Entry>> _entriesStreamController;
  Stream<List<Entry>> get entries =>
      _entriesStreamController.stream.asBroadcastStream();

  Future<void> logIn(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      user = credential.user;
      await _listenForEntries();
    } on FirebaseAuthException catch (e) {
      print('Login failed: ${e.message}');
      user = null;
      rethrow;
    }
  }

  void writeEntryToFirebase(Entry entry) {
    print('TODO: AppState.writeEntryToFirebase');
  }

  Future<void> _listenForEntries() async {
    print('TODO: AppState._listenForEntries');
  }
}

const lorem =
'''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod  tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum
    ''';