import 'package:alta_pos/models/profile.dart';
import 'package:alta_pos/utils/global.dart';
import 'package:firebase_auth/firebase_auth.dart';


Future<String> signIn(String email, String password) async {
  print('signing in..');
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );

    User? user = userCredential.user;

    userProfile = new Profile(
      user!.displayName ?? "user",
      user.email ?? "email",
      user.uid
    );

    return 'user-signed-in';

  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
    return e.code;
  }
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}