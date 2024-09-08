import 'package:b2clients/features/app/account/change_language_page.dart';
import 'package:b2clients/features/app/app_widgets/flutter_toast.dart';
import 'package:b2clients/services/firebase_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthUtils {
  FirebaseUtils firebaseUtils = FirebaseUtils();
  CollectionReference accountsCollectionReference =
      FirebaseFirestore.instance.collection('accounts');
  FlutterToast flutterToast = FlutterToast();

// SIGN IN
  Future signIn(
    TextEditingController emailController,
    TextEditingController passwordController,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      emailController.clear();
      passwordController.clear();

      return true;
    } on FirebaseAuthException catch (e) {
      e.code == "user-disabled"
          ? flutterToast.showToast(
              message:
                  "The user corresponding to the given email has been disabled.",
              color: Colors.red)
          : e.code == "user-not-found"
              ? flutterToast.showToast(
                  message: "There is no such user.", color: Colors.red)
              : e.code == "wrong-password"
                  ? flutterToast.showToast(
                      message: "Wrong login or password.", color: Colors.red)
                  : flutterToast.showToast(
                      message: 'Operation failed. Try again',
                      color: Colors.red);
      return false;
    }
  }

  // RESET PASSWORD

  Future resetPassword(
      TextEditingController emailController, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      flutterToast.showToast(
          message: 'We have successfully sent you a mail', color: Colors.green);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      flutterToast.showToast(message: e.message.toString(), color: Colors.red);
    }

    emailController.clear();
  }

  // SIGN UP

  Future signUp(
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController,
  ) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text);

      passwordController.clear();
      confirmPasswordController.clear();
      // email verification

      await FirebaseAuth.instance.currentUser!.sendEmailVerification();

      // add email and uid to account
      addInitialAccountData();

      return true;
    } on FirebaseAuthException catch (e) {
      e.code == "email-already-in-use"
          ? flutterToast.showToast(
              message: "This email address already in use.", color: Colors.red)
          : e.code == "invalid-email"
              ? flutterToast.showToast(
                  message: "Invalid email.", color: Colors.red)
              : flutterToast.showToast(
                  message: 'Operation failed. Try again', color: Colors.red);
      return false;
    }
  }

  Future addInitialAccountData() async {
    User currentUser = FirebaseAuth.instance.currentUser!;
    await accountsCollectionReference.doc(currentUser.uid).set({
      'uid': currentUser.uid,
      'email': currentUser.email,
      'create_time': currentUser.metadata.creationTime,
      'update_time': currentUser.metadata.creationTime,
      'phone_number': '',
      'name': '',
      'surname': '',
      'is_email_verified': currentUser.emailVerified,
      'agreement': {
        'isUserAcceptThePublicOffer': false,
        'isUserAcceptTermsOfUse': false,
        'isUserAcceptPrivacyPolicy': false,
      },
      'employment_type': {
        'company_member': false,
        'private_specialist': true,
      },
      'service_types': [],
      'clients_reviews': []
    });
  }

// ADD USER NAME, SURNAME AND AGREEMENT INFO
  Future addAdditionalAccountData(TextEditingController nameController,
      TextEditingController surnameController) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    await currentUser.updateDisplayName(
        '${nameController.text.trim()} ${surnameController.text.trim()}');

    firebaseUtils.updateUserAccountData({
      'users_to_chating': [],
      'name': nameController.text.trim(),
      'surname': surnameController.text.trim(),
      'agreement': {
        'isUserAcceptThePublicOffer': true,
        'isUserAcceptTermsOfUse': true,
        'isUserAcceptPrivacyPolicy': true,
        'timeOfConsent': Timestamp.now()
      }
    });

    nameController.clear();
    surnameController.clear();
  }
}
