// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, duplicate_ignore, sized_box_for_whitespace, unused_local_variable, avoid_print

//import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'sign_in_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController forgetPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Forgot Password",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        // ignore: prefer_const_literals_to_create_immutables
        // actions: [
        //   Icon(Icons.more_vert),
        // ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 250.0,
                child: Lottie.asset("assets/register.json"),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: forgetPasswordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    //suffixIcon: Icon(Icons.email),
                    hintText: 'Email',
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 3.0,
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
                ),
                onPressed: () async {
                  var forgotEmail = forgetPasswordController.text.trim();

                  try {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: forgotEmail)
                        .then((value) => {
                              print("Email Sent!"),
                              Get.off(() => LoginScreen()),
                            });
                  } on FirebaseAuthException catch (e) {
                    print("Error $e");
                  }
                },
                child: Text("Forgot Password"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
