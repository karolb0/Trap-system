import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError('DefaultFirebaseOptions not configured for iOS.');
      case TargetPlatform.macOS:
        throw UnsupportedError('DefaultFirebaseOptions not configured for macOS.');
      case TargetPlatform.windows:
        throw UnsupportedError('DefaultFirebaseOptions not configured for Windows.');
      case TargetPlatform.linux:
        throw UnsupportedError('DefaultFirebaseOptions not configured for Linux.');
      default:
        throw UnsupportedError('Unsupported platform.');
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBpKa96LMYvTMTRT9PXnLCYBL0O-rAkTlU',
    appId: '1:542189992531:android:377a89b80c7e4d8b2524a6',
    messagingSenderId: '542189992531',
    projectId: 'trapp-e915b',
    storageBucket: 'trapp-e915b.appspot.com',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDEQwOeB_JEegypcDw8vVjCHFFAUuaEsMA',
    appId: '1:885757608419:web:5ec8569d01da628b2c20d6',
    messagingSenderId: '885757608419',
    projectId: 'trapp-e915b',
    authDomain: 'trapp-e915b.firebaseapp.com',
    storageBucket: 'trapp-e915b.appspot.com',
  );
}
