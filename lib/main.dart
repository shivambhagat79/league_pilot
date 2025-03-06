import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hunger_games/components/logincr/Login_Main.dart';
import 'package:hunger_games/pages/landing.dart';
import 'firebase_options.dart';
// import 'package:hunger_games/pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'League Pilot',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const login(),
      debugShowCheckedModeBanner: false,
    );
  }
}
