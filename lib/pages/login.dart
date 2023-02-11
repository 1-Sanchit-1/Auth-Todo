import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_all/pages/auth.dart';
import 'package:flutter_auth_all/pages/forgetpassword.dart';
import 'package:flutter_auth_all/pages/signup.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'home.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  var emailc = TextEditingController();
  var passwordc = TextEditingController();
  bool _isLoading = false;

  void login() async {
    setState(() {
      _isLoading = true;
    });
    String res =
        await Auth().signin(email: emailc.text, password: passwordc.text);
    setState(() {
      _isLoading = false;
    });
    if (res != null) {
      var snackBar = SnackBar(content: Text("Login Successfully"),backgroundColor: Colors.cyanAccent,);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ));
    } else {
      var snackBar = SnackBar(content: Text("Not Registered"),backgroundColor: Colors.red,);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  google() async {
    setState(() {
      _isLoading = true;
    });
    if (_isLoading == true) {
      Center(child: CircularProgressIndicator());
    }
    UserCredential res = await Auth().googlesignin();
    setState(() {
      _isLoading = false;
    });
    print(res);
    if (res != null) {
      var snackBar = SnackBar(content: Text("Login Successfully"),backgroundColor: Colors.cyanAccent,);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ));
    } else {
      var snackBar = SnackBar(content: Text("Something Error"),backgroundColor: Colors.red,);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void dispose() {
    emailc.dispose();
    passwordc.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_sharp,
                      size: 122,
                    ),
                  ],
                ),
                Text("Login",
                    style: TextStyle(
                        fontSize: 44,
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 25,
                ),
                Divider(),
                TextField(
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: "Email or username",
                    fillColor: Colors.white,
                    hintText: "abc@gmail.com",
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  controller: emailc,
                ),
                Divider(),
                SizedBox(
                  height: 15,
                ),
                Divider(),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: "Password",
                    fillColor: Colors.white,
                    hintText: "******",
                    icon: Icon(Icons.lock_open),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  controller: passwordc,
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => forget(),
                              ));
                        },
                        child: Text("Forgot Password")),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.green),
                      shadowColor: MaterialStateProperty.all(Colors.red),
                      minimumSize:
                          MaterialStateProperty.all(const Size(200, 40)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    onPressed: () {
                      login();
                    },
                    child: _isLoading
                        ? Center(child: LinearProgressIndicator())
                        : Text("Login")),
                SizedBox(
                  height: 15,
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Or Sign Up Using",
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Divider(),
                Column(
                  children: [
                    SignInButton(
                      Buttons.Google,
                      onPressed: () {
                        google();
                      },
                    ),
                    // SignInButton(
                    //   Buttons.Facebook,
                    //   onPressed: () {},
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     SignInButton(
                    //       mini: true,
                    //       Buttons.LinkedIn,
                    //       onPressed: () {},
                    //     ),
                    //     SignInButton(
                    //       mini: true,
                    //       Buttons.GitHub,
                    //       onPressed: () {},
                    //     ),
                    //   ],
                    // )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    Text(
                      "Don't Have an account",
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => signup(),
                              ));
                        },
                        child: Text("SignUp")),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
