import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:memo_flutter/screens/memo_main_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 🔒 안전하게 필수 호출
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MemoApp());
}

class MemoApp extends StatelessWidget {
  const MemoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: MemoMainScreen(),
    );
  }
}