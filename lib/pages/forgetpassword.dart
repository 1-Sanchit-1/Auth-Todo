import 'package:flutter/material.dart';
import 'package:flutter_auth_all/pages/auth.dart';

class forget extends StatefulWidget {
  const forget({Key? key}) : super(key: key);

  @override
  State<forget> createState() => _forgetState();
}

class _forgetState extends State<forget> {
  TextEditingController email = TextEditingController() ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        centerTitle: true,
        title: Text("Foreget Password" ,style: TextStyle(
          color: Colors.black
        ),),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: 90,
            ),
            Text("Email For Forget Password"),
            SizedBox(
              height: 12,
            ),
            TextField(
              focusNode: primaryFocus,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.black),
                labelText: "Email",
                fillColor: Colors.white,
                hintText: "abc@gmail.com",
                icon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              controller: email,
            ),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(onPressed: () {
              Auth().forget(email: email.text) ;
            }, child: Text("Send Link")),
          ],
        ),
      ),
    );
  }
}
