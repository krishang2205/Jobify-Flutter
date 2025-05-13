// Replace these values with your Firebase web config
// Get from Firebase Console > Project Settings > Web App configuration

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: "AIzaSyB4QG4xmSGtrmQ8xgYJQAluyzy_649ppaw",
      appId: "1:56750275303:web:bdf5d1e4fcd0956ffd0042",
      messagingSenderId: "56750275303",
      projectId: "jobify-14d03",
      authDomain: "jobify-14d03.firebaseapp.com",
      databaseURL: "https://jobify-14d03-default-rtdb.firebaseio.com",
      measurementId: "G-N7P8K9LFLH",
      storageBucket: "jobify-14d03.appspot.com",
    );
  }
}
