import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Import Firebase Auth
import 'features/user_auth/presentation/screen/home.dart';
import 'features/user_auth/presentation/screen/login.dart';
import 'features/user_auth/presentation/screen/signup.dart';
import 'features/user_auth/presentation/screen/splash.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDebQ3e70COyu_H60itGFIhjyHkgsR2_5c",
        appId: "1:561970985581:web:defaf652136d79ed9c1d64",
        messagingSenderId: "561970985581",
        projectId: "flutter-signup-2bbe1",
        // Your web Firebase config options
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      routes: {
        '/': (context) => Mysplash(
          // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
          child: LoginPage(),
        ),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}