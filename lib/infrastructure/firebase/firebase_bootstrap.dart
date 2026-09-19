import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';

abstract interface class FirebaseBootstrapper {
  Future<void> initialize();
}

class DefaultFirebaseBootstrapper implements FirebaseBootstrapper {
  @override
  Future<void> initialize() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }

    await FirebaseAppCheck.instance.activate(
      providerAndroid: AndroidDebugProvider(),
    );
  }
}
