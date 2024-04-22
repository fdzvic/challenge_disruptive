import 'package:challenge_disruptive/app.dart';
import 'package:challenge_disruptive/common/firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  FlavorConfig(
    name: "QA",
    variables: {
      "baseUrl": "",
    },
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: App()));
}
