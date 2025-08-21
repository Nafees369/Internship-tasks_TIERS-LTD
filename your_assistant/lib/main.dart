
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your Assistant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.deepPurpleAccent,
        scaffoldBackgroundColor: Colors.transparent,
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      home: const VoiceAssistantPage(),
    );
  }
}
class DefaultFirebaseOptions {
static FirebaseOptions get currentPlatform {
if (kIsWeb) {
throw UnsupportedError(
'DefaultFirebaseOptions have not been configured for windows - '
'you can reconfigure this by running the FlutterFire CLI again.',
);
}
switch (defaultTargetPlatform) {
case TargetPlatform.android:
return android;
case TargetPlatform.iOS:
throw UnsupportedError(
'DefaultFirebaseOptions have not been configured for iOS'
'you can reconfigure this by running the FlutterFire CLI again.',

);
case TargetPlatform.macOS:
throw UnsupportedError(
'DefaultFirebaseOptions have not been configured for macOS'
'you can reconfigure this by running the FlutterFire CLI again.',

);
case TargetPlatform.windows:
throw UnsupportedError(
'DefaultFirebaseOptions have not been configured for windows'
'you can reconfigure this by running the FlutterFire CLI again.',

);
case TargetPlatform.linux:
throw UnsupportedError(
'DefaultFirebaseOptions have not been configured for linux'
'you can reconfigure this by running the FlutterFire CLI again.',

);
default:
throw UnsupportedError(
'DefaultFirebaseOptions are not supported for this platform.',
);
}
}
static const FirebaseOptions android = FirebaseOptions(
  apiKey: "AIzaSyDGj5fJjPH19nezo1lysfdU4x3r4L0mvMg",
  appId: '1:333404235928:android:12911eca36bee9c1e708ed',
  messagingSenderId: '333404235928',
  projectId: 'your-assistant-4d05d',
);
}


