// ignore_for_file: prefer_const_constructors, unnecessary_import, file_names, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, unnecessary_null_comparison, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'views/create_note_screen.dart';
import 'views/edit_note_screen.dart';
import 'views/sign_in_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Home Screen",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Get.off(() => LoginScreen());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("notes")
              .where("userId", isEqualTo: userId?.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong!");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text("No Data Found!"),
              );
            }

            if (snapshot != null && snapshot.data != null) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var note = snapshot.data!.docs[index]['note'];
                  var noteId = snapshot.data!.docs[index]['userId'];
                  var docId = snapshot.data!.docs[index].id;
                  Timestamp date = snapshot.data!.docs[index]['createdAt'];
                  var finalDate = DateTime.parse(date.toDate().toString());

                  return Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0),
                      title: Text(
                        note,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        GetTimeAgo.parse(finalDate),
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                () => EditNoteScreen(),
                                arguments: {
                                  'note': note,
                                  'docId': docId,
                                },
                              );
                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.black, // Customize icon color
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await FirebaseFirestore.instance
                                  .collection("notes")
                                  .doc(docId)
                                  .delete();
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.black, // Customize icon color
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Get.to(() => CreateNoteScreen());
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
