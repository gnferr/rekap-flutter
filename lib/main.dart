import 'package:flutter/material.dart';
import 'package:learning_udemy/17Aug_Spring/create.dart';
import 'package:learning_udemy/17Aug_Spring/flutterxspring.dart';
import 'package:learning_udemy/Rekap_materi/real_homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => RealHomepage(),
        "/fspring": (context) => HomePage(),
        "/updateuser": (context) => UpdateUser(),
      },
      initialRoute: "/",
    );
  }
}
