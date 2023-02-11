import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_all/pages/login.dart';
import 'package:flutter_auth_all/pages/splesh.dart';
import 'package:get/get.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb)
    {
      await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCwCd813uxsJoWfjTdMn1_7rEcb0Ou3jCM",
            appId: "1:1056321614392:web:743aa2bf82077ffebcaccd",
            messagingSenderId: "1056321614392",
            projectId: "connection-d8f70")
      );
    }
  else
    {
      await Firebase.initializeApp();
    }

  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: spleshscreen(),
    );
  }
}

