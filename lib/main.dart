import 'app/app.dart';

import 'package:flutter/material.dart';

import 'infrastructure/firebase/firebase_bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DefaultFirebaseBootstrapper().initialize();
  runFinanceTracker();
}
