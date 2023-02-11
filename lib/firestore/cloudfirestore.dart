import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class store {

  addtasks({required String title, required String dec}) async {
    firebaseFirestore
        .collection('tasks')
        .add({
          'title': title,
          'description': dec,
        })
        .whenComplete(() => SnackBar(content: Text("Add data")))
        .catchError((e) {
          SnackBar(
            content: Text("${e.toString()}"),
          );
        });
  }

  read() {
    final docuser = FirebaseFirestore.instance
        .collection('tasks')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  update(
      {required String id, required String title, required String des}) async {
    await firebaseFirestore.collection("tasks").doc(id).update({
      'title': title,
      'description': des,
    });
  }

  delete({required String id}) async {
    await firebaseFirestore.collection('tasks').doc(id).delete();
  }
}
