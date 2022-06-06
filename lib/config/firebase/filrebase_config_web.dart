// ignore: deprecated_member_use
import 'package:firebase/firebase.dart' as fb;

class FirebaseConfigs {
  FirebaseConfigs._();

  static void configuration() {
    // Break if the app is already initialized.
    if (fb.apps.isNotEmpty) return;
    // Checking environment to get the config.
    fb.initializeApp(
      apiKey: "AIzaSyAwxTVK6_8AOOI0QiU3dUo3tD2UUQZu8MQ",
      authDomain: "homeservicedev-348702.firebaseapp.com",
      projectId: "homeservicedev-348702",
      storageBucket: "homeservicedev-348702.appspot.com",
      messagingSenderId: "1037388754263",
      appId: "1:1037388754263:web:6df4d70f694bc7d28fe212",
      measurementId: "G-V20TNWZKRN",
    );
  }
}
