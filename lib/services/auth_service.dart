import 'package:b2clients/features/app/app_widgets/flutter_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  // SEND OTP CODE
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static String verifyId = '';
  final FlutterToast flutterToast = FlutterToast();
  static Future sendOTP({
    required String phoneNumber,
    required Function errorStep,
    required Function nextStep,
  }) async {
    await _firebaseAuth
        .verifyPhoneNumber(
      timeout: const Duration(seconds: 30),
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) async {
        return;
      },
      verificationFailed: (error) async {
        return;
      },
      codeSent: (verificationId, forceResendingTocken) async {
        verifyId = verificationId;
        nextStep();
      },
      codeAutoRetrievalTimeout: (verificationId) async {
        return;
      },
    )
        .onError((error, stackTrace) {
      errorStep();
    });
  }

  // VERIFY OPT CODE
  static Future updatePhoneNumber({required String opt}) async {
    final cred =
        PhoneAuthProvider.credential(verificationId: verifyId, smsCode: opt);

    try {
      await _firebaseAuth.currentUser!.updatePhoneNumber(cred);

      if (_firebaseAuth.currentUser != null) {
        return 'Success';
      } else {
        return 'Error';
      }
    } on FirebaseAuthException catch (e) {
      FlutterToast()
          .showToast(message: e.message.toString(), color: Colors.red);
      // return e.message.toString();
    } catch (e) {
      FlutterToast().showToast(message: e.toString(), color: Colors.red);
      // return e.toString();
    }
  }

  // TO LOGOUT
  static Future logout() async {
    await _firebaseAuth.signOut();
  }

  // IS USER LOGGED
  static Future<bool> isLoggedIn() async {
    var user = _firebaseAuth.currentUser;
    return user != null;
  }
}
