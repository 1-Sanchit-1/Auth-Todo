import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {

  var emailc = TextEditingController();
  var passwordc = TextEditingController();
  var conpassword = TextEditingController();

  // FirebaseAuth _auth=FirebaseAuth.instance ;

  bool _isLoading = false;
  void signup() async {
    setState(() {
      _isLoading = true;
    });
    String res =
        await Auth().register(email: emailc.text, password: passwordc.text);
    setState(() {
      _isLoading = false;
    });
    if (res == "success") {
      Navigator.pop(context);
      var snackBar = SnackBar(content: Text("Register Successfully"),backgroundColor: Colors.cyanAccent,);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      var snackBar = SnackBar(content: Text("Something Incorrect"),backgroundColor: Colors.red,);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

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
                Text("Sign Up",
                    style: TextStyle(
                        fontSize: 44,
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 25,
                ),
                Divider(),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  autofocus: true,
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
                    hintText: "Password should at leat six digit",
                    icon: Icon(Icons.lock_open),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  controller: passwordc,
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: "Confirm Password",
                    fillColor: Colors.white,
                    hintText: "******",
                    icon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  controller: conpassword,
                ),
                Divider(),
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
                      if(passwordc.text==conpassword.text && emailc!=null )
                        {
                           signup();
                        }
                      else
                        {
                          var snackBar = SnackBar(content: Text("Please fill all field correct "),backgroundColor: Colors.red,);
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }

                    },
                    child: _isLoading == true
                        ? Center(child: LinearProgressIndicator())
                        :Text("SignUp")),
                SizedBox(
                  height: 15,
                ),
                Divider(),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       "Or Sign Up Using",
                //       style: TextStyle(
                //         color: Colors.lightBlue,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ],
                // ),
                // Divider(),
                // Column(
                //   // mainAxisAlignment:MainAxisAlignment.center,
                //   children: [
                //     SignInButton(
                //       Buttons.Google,
                //       onPressed: () async {
                //         try {
                //           await GoogleSignIn(signInOption: SignInOption.games);
                //         } catch (error) {
                //           print(error);
                //         }
                //       },
                //     ),
                //     SignInButton(
                //       Buttons.Facebook,
                //       onPressed: () {},
                //     ),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         SignInButton(
                //           mini: true,
                //           Buttons.LinkedIn,
                //           onPressed: () {},
                //         ),
                //         SignInButton(
                //           mini: true,
                //           Buttons.GitHub,
                //           onPressed: () {},
                //         ),
                //       ],
                //     )
                //   ],
                // ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    Text(
                      "Already Have an account",
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Signin")),
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
