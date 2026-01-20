// Placeholder Firebase options. Replace with values from `flutterfire configure`.
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        return linux;
      default:
        throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
    }
  }

  // Fill these with real values from the Firebase console or `flutterfire configure`.
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyB1oNQC5CXWyE94y8hbXXOimwidZ4isPWA",
    authDomain: "uas-pemmob-af7ac.firebaseapp.com",
    projectId: "uas-pemmob-af7ac",
    storageBucket: "uas-pemmob-af7ac.firebasestorage.app",
    messagingSenderId: "698621463397",
    appId: "1:698621463397:web:3bfdeef2e0df09e323ef8c"
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD-4425XkEzBYIHn_bd8UrdQlBBZucictM',
    appId: '1:698621463397:android:7d067c9b965b801823ef8c',
    messagingSenderId: '698621463397',
    projectId: 'uas-pemmob-af7ac',
    storageBucket: 'uas-pemmob-af7ac.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAzjTfSlEaVIo8xdzu7SK7A1Kdz8oSxCFA',
    appId: '1:698621463397:ios:1800bf0e68ed8e8923ef8c',
    messagingSenderId: '698621463397',
    projectId: 'uas-pemmob-af7ac',
    iosBundleId: 'com.example.uasPemmob',
    storageBucket: 'uas-pemmob-af7ac.firebasestorage.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAzjTfSlEaVIo8xdzu7SK7A1Kdz8oSxCFA',
    appId: '1:698621463397:ios:1800bf0e68ed8e8923ef8c',
    messagingSenderId: '698621463397',
    projectId: 'uas-pemmob-af7ac',
    iosBundleId: 'com.example.uasPemmob',
    storageBucket: 'uas-pemmob-af7ac.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBn9xmEaJZEH4XAEG8_rqVvKL5oVz3jQOc',
    appId: '1:698621463397:web:1234567890abcdef',
    messagingSenderId: '698621463397',
    projectId: 'uas-pemmob-af7ac',
    authDomain: 'uas-pemmob-af7ac.firebaseapp.com',
    storageBucket: 'uas-pemmob-af7ac.firebasestorage.app',
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: 'AIzaSyBn9xmEaJZEH4XAEG8_rqVvKL5oVz3jQOc',
    appId: '1:698621463397:web:1234567890abcdef',
    messagingSenderId: '698621463397',
    projectId: 'uas-pemmob-af7ac',
    authDomain: 'uas-pemmob-af7ac.firebaseapp.com',
    storageBucket: 'uas-pemmob-af7ac.firebasestorage.app',
  );
}
