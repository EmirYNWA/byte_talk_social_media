import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../domain/entities/app_user.dart';
import '../domain/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password)async {
    try{
      UserCredential userCredential = await firebaseAuth.
      signInWithEmailAndPassword(email:email,password:password);

      DocumentSnapshot userDoc = await firebaseFirestore
          .collection('users')
          .doc(userCredential.user?.uid)
          .get();


      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email:email,
        name: userDoc['name'],
        // username: userCredential.user!.user,
      );

      return user;
    }
    catch(e){
      throw Exception('Login failed: $e');
    }
  }

  Future<void> sendVerificationEmail(User? user) async {
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      print("Verification email sent to ${user.email}");
    }
  }

  @override
  Future<AppUser?> registerWithEmailPassword(String name,String email, String password) async {
    try{
      UserCredential userCredential = await firebaseAuth.
      createUserWithEmailAndPassword(email:email,password:password);

      const SnackBar(content: Text("Verification e-mail has been sent!")
        , duration: Duration(seconds: 2),) ;

      await sendVerificationEmail(userCredential.user);

      AppUser user = AppUser(
          uid: userCredential.user!.uid,
          email:email,
          name: name,
      );

      await firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .set(user.toJson());

      return user;
    }
    catch(e){
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final firebaseUser = firebaseAuth.currentUser;

    // no user logged in..
    if(firebaseUser==null){
      return null;
    }

    DocumentSnapshot userDoc = await firebaseFirestore
        .collection('users')
        .doc(firebaseUser.uid)
        .get();

    if (!userDoc.exists) {
      return null;
    }

    //user exist
    return AppUser(
        uid: firebaseUser.uid,
        email: firebaseUser.email!,
        name: userDoc['name'],
    );
  }
}
