import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';

class splashservie {

  void isLogin(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    if (user != null) {
      Timer(
          Duration(seconds: 1),
          () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              )));
    } else {
      Timer(
          Duration(seconds: 5),
          () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => login(),
              )));
    }
  }
}
