// ignore_for_file: prefer_const_constructors, file_names, avoid_unnecessary_containers, unnecessary_string_interpolations

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home_screen.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          "Edit Note",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Container(
            child: Column(
          children: [
            TextFormField(
              controller: noteController
                ..text = "${Get.arguments['note'].toString()}",
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 3.0,
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
              ),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("notes")
                    .doc(Get.arguments['docId'].toString())
                    .update(
                  {
                    'note': noteController.text.trim(),
                  },
                ).then((value) => {
                          Get.offAll(() => HomeScreen()),
                          log("Data Updated"),
                        });
              },
              child: Text("Update"),
            ),
          ],
        )),
      ),
    );
  }
}
