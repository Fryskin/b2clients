import 'package:b2clients/features/auth/register/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  FirebaseFirestore database = FirebaseFirestore.instance;

  Future addEmailAndUserID() async {
    // ADD USER EMAIL AND USER'S ID TO ACCOUNT
    User currentUser = FirebaseAuth.instance.currentUser!;

    await database.collection('accounts').add({
      'uid': currentUser.uid,
      'email': currentUser.email,
      'create_time': currentUser.metadata.creationTime,
      'updateTime': currentUser.metadata.creationTime,
      'phone_number': '',
    });
  }

  // SIGN UP
  Future signUp(TextEditingController email, TextEditingController password,
      TextEditingController comfirmPassword, BuildContext context) async {
    bool isPasswordConfirmed() {
      return password.text.trim() == comfirmPassword.text.trim();
    }

    if (isPasswordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.trim(), password: password.text);
      // EMAIL VERIFICATION
      print(FirebaseAuth.instance.currentUser!);
      addEmailAndUserID();
      password.clear();
      comfirmPassword.clear();
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } else {
      password.clear();
      comfirmPassword.clear();
      return false;
    }
  }
}
