import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'features/user_auth/presentation/screen/intro.dart';
// Import Firebase Auth
import 'features/user_auth/presentation/screen/home.dart';
import 'features/user_auth/presentation/screen/splash.dart';
import 'features/user_auth/presentation/screen/login.dart';
import 'features/user_auth/presentation/screen/signup.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDebQ3e70COyu_H60itGFIhjyHkgsR2_5c",
        appId: "1:561970985581:web:defaf652136d79ed9c1d64",
        messagingSenderId: "561970985581",
        projectId: "flutter-signup-2bbe1",
        // Your web Firebase config options
      ),
    );
  } else {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyDebQ3e70COyu_H60itGFIhjyHkgsR2_5c",
      appId: "1:561970985581:web:defaf652136d79ed9c1d64",
      messagingSenderId: "561970985581",
      projectId: "flutter-signup-2bbe1",
    ));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      routes: {
        '/': (context) => const Mysplash(
              // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
               child: Myintro(child: null,),
            ),
       '/login': (context) => const LoginPage(),
        '/signUp': (context) => const SignUpPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
