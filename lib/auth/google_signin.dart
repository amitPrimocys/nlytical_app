// // ignore_for_file: avoid_print
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
// import 'package:google_sign_in/google_sign_in.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;
// final GoogleSignIn googleSignIn = GoogleSignIn();

// String? name;
// String? email;
// String? imageUrl;
// String? userId;
// String data = "";
// Future<String> signInWithGoogle(BuildContext context) async {
//   final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

//   // final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
//   final GoogleSignInAuthentication googleSignInAuthentication =
//       await googleSignInAccount!.authentication;

//   final AuthCredential credential = GoogleAuthProvider.credential(
//     accessToken: googleSignInAuthentication.accessToken,
//     idToken: googleSignInAuthentication.idToken,
//   );

//   final UserCredential authResult =
//       await _auth.signInWithCredential(credential);
//   final firebase_auth.User user = authResult.user!;

//   // final AuthResult authResult = await _auth.signInWithCredential(credential);
//   // final FirebaseUser user = authResult.user;

//   // Checking if email and name is null
//   assert(user.email != null);
//   assert(user.displayName != null);
//   assert(user.photoURL != null);

//   name = user.displayName;
//   email = user.email;
//   imageUrl = user.photoURL;
//   userId = user.uid;

//   print(name);
//   print(email);
//   print(imageUrl);

//   // Only taking the first part of the name, i.e., First Name
//   // if (name.contains(" ")) {
//   //   name = name.substring(0, name.indexOf(" "));
//   // }

//   assert(!user.isAnonymous);
//   assert(await user.getIdToken() != null);

//   final firebase_auth.User currentUser = authResult.user!;
//   assert(user.uid == currentUser.uid);

//   // ignore: unnecessary_null_comparison
//   if (user.uid != null) {
//     FirebaseMessaging.instance.getToken().then((token) {
//       print("👌👌👌👌👌👌👌👌👌👌👌👌👌👌");
//       // social login api
//       // _userDataPost(context, token!);
//     });
//   }
//   // ignore: use_build_context_synchronously
//   //_userDataPost(context, fcmtoken);
//   return 'signInWithGoogle succeeded: $user';
// }

// void signOutGoogle() async {
//   await googleSignIn.signOut();

//   print("User Sign Out");
// }
