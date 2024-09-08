import 'package:b2clients/business_to_clients_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Firebase.initializeApp(
    name: 'BissToCliForCli',
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAeGvtILVDfnvteESAlbEMK4kVlpwJbdAU',
      appId: '1:381969372251:web:3c1230c1679cb558a2db7e',
      messagingSenderId: '381969372251',
      projectId: 'biss-to-cli-for-cli',
      authDomain: 'biss-to-cli-for-cli.firebaseapp.com',
      storageBucket: 'biss-to-cli-for-cli.appspot.com',
      measurementId: 'G-ZVFNGWLQK5',
    ),
  );
  // FirebaseAppChec firebaseAppCheck = FirebaseAppCheck.getInstance();
  //  firebaseAppCheck.installAppCheckProviderFactory( SafetyNetAppCheckProviderFactory.getInstance());

  runApp(const BusinessToClientsApp(languageCode: 'cs'));
}
