

import 'package:flutter/material.dart';
import 'package:flutter_auth_all/pages/spleshservice.dart';

class spleshscreen extends StatefulWidget {
  const spleshscreen({Key? key}) : super(key: key);

  @override
  State<spleshscreen> createState() => _spleshscreenState();
}

class _spleshscreenState extends State<spleshscreen> {

  splashservie splesh =splashservie() ;
  @override
  void initState() {
    splesh.isLogin(context);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       Colors.blue,
        //       Colors.yellow,
        //       Colors.deepPurple,
        //       Colors.cyanAccent,
        //     ]
        //   )
        // ),
        child: Center(
          child: Column(
            children: [
              Image.network("https://www.shutterstock.com/image-vector/welcome-poster-spectrum-brush-strokes-600w-1146069941.jpg" ,fit: BoxFit.fitHeight ),
              Text("Welcome",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 55,
                color: Colors.black,
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
