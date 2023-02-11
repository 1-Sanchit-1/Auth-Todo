import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  register({required String email, required String password}) async {
    String res = "something error";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(user.user!.uid);
        res = "success";
      }
    } on FirebaseAuthException catch (e) {
      GetSnackBar(title: "${e.message}");
    }
    return res;
  }

  signin({required String email, required String password}) async {
    String res = "something error";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        var result = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      }
    } on FirebaseAuthException catch (e) {
      GetSnackBar(title: e.message);
    }
    return res;
  }

  logout() async {
    String res = "something error";
    try {
      await _auth.signOut();
      res = "success";
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
    return res;
  }

  forget({required String email})async{
    try{
      await _auth.sendPasswordResetEmail(email: email).then((_) =>
      GetSnackBar(title: "link has been sent to your email for password reset",) );
    }on FirebaseAuthException catch(e){
       GetSnackBar(title: "${e.message}",);
    }
  }

  googlesignin()async{

    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =await googleSignIn.signIn();
    if(googleSignInAccount!=null)
      {
        final GoogleSignInAuthentication googleSignInAuthentication=
            await googleSignInAccount.authentication ;
        final AuthCredential authCredential =GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken ,
          idToken: googleSignInAuthentication.idToken,
        );
        return await _auth.signInWithCredential(authCredential);
        // User? user = result.user ;
        // return result ;
      }
  }
}
