// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_screen.dart';
import 'views/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //for plateform error -> applevel build.gradle

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCKAWa40eJho6Z25Ad0lGV6lzsqNF1eNW0",
      appId: "1:729142601350:android:14abd8858e301881a3d307",
      messagingSenderId: "729142601350",
      projectId: "my-note-a66f2",
    ),
  );

  //till here
  await Firebase.initializeApp();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    print(user?.uid.toString());
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: user != null ? const HomeScreen() : const LoginScreen(),
    );
  }
}
