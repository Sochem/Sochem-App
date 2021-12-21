import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

//firebase auth
// class Authentication {
//   static final googleSignIn = GoogleSignIn(
//     scopes: ['profile', 'email', 'openid'],
//     hostedDomain: 'itbhu.ac.in',
//   );
//   static Future<FirebaseApp> initializeFirebase(
//       {required BuildContext context}) async {
//     FirebaseApp firebaseApp = await Firebase.initializeApp();
//     User? user = FirebaseAuth.instance.currentUser;

//     if (user != null) {
//       //TODO: Add logic to stay at homepage
//       print("looged in");
//     }

//     return firebaseApp;
//   }

//   static SnackBar customSnackBar({required String content}) {
//     return SnackBar(
//       backgroundColor: Colors.black,
//       content: Text(
//         content,
//         style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
//       ),
//     );
//   }

//   static Future<User?> signInWithGoogle({required BuildContext context}) async {
//     FirebaseAuth auth = FirebaseAuth.instance;

//     final GoogleSignInAccount? googleUser;
//     try {
//       googleUser = await googleSignIn.signIn();
//     } catch (e) {
//       print('google sign in error: ${e.toString()}');
//       return null;
//     }
//     if (googleSignIn == null) {
//       return null;
//     }
//     final googleAuth = await googleUser!.authentication;
//     final credential = GoogleAuthProvider.credential(
//       idToken: googleAuth.idToken,
//       accessToken: googleAuth.accessToken,
//     );
//     User? user;
//     try {
//       user = (await auth.signInWithCredential(credential)).user;
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         Authentication.customSnackBar(
//           content: 'google sign in error: ${e.toString()}',
//         ),
//       );
//       await signOutGoogle();
//       return null;
//     }

//     String idToken = (await user!.getIdToken());

//     assert(await user.getIdToken() != null);

//     final currentUser = FirebaseAuth.instance.currentUser;

//     assert(user.uid == currentUser!.uid);

//     await verifyToken(idToken);

//     return currentUser;
//   }

//   static verifyToken(String idToken) async {
//     // backend token
//   }

//   static Future<void> signOutGoogle() async {
//     if (googleSignIn != null) {
//       await googleSignIn.signOut();
//     }
//     await FirebaseAuth.instance.signOut();
//     print("User Sign Out");
//   }
// }

//outh2.0
class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn(
    scopes: ['profile', 'email', 'openid'],
    hostedDomain: 'itbhu.ac.in',
  );
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
}
