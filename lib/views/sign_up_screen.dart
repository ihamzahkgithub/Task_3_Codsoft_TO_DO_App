// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, duplicate_ignore, sized_box_for_whitespace, unused_local_variable

//import 'dart:html';

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../services/signUpServices.dart';
import 'sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "SignUp Screen",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    //suffixIcon: Icon(Icons.email),
                    hintText: 'UserName',
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: userPhoneController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    //suffixIcon: Icon(Icons.email),
                    hintText: 'Phone',
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: userEmailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    //suffixIcon: Icon(Icons.email),
                    hintText: 'Email',
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: userPasswordController,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      enabledBorder: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: Icon(
                        Icons.visibility,
                      )),
                ),
              ),
              SizedBox(
                height: 10.0,
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
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 60.0),
                ),
                onPressed: () async {
                  var userName = userNameController.text.trim();
                  var userPhone = userPhoneController.text.trim();
                  var userEmail = userEmailController.text.trim();
                  var userPassword = userPasswordController.text.trim();

                  await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: userEmail, password: userPassword)
                      .then((value) => {
                            log("User Created"),
                            signUpUser(
                              userName,
                              userPhone,
                              userEmail,
                              userPassword,
                            ),
                          });
                },
                child: Text("Sign Up"),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => LoginScreen());
                },
                child: Container(
                  child: Card(
                    color: Colors.white12,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Already have an account Sign In"),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
