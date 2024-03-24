import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../../firebase_auth_implementation/firebase_auth_services.dart';
import 'home2.dart';
import '../../widgets/form_container_widget.dart';
import '../../../../global/toast.dart';


class LoginPage2 extends StatefulWidget {
  const LoginPage2({super.key});

  @override
  _LoginPage2State createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  bool _isSigning = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Login'),
      ),

        body: Center(
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text(
    "Login",
    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
    ),
    SizedBox(
    height: 30,
    ),
    FormContainerWidget(
    controller: _emailController,
    hintText: "Email",
    isPasswordField: false,
    ),
    SizedBox(
    height: 10,
    ),
    FormContainerWidget(
    controller: _passwordController,
    hintText: "Password",
    isPasswordField: true,
    ),
    SizedBox(
    height: 30,
    ),
    GestureDetector(
    onTap: () {
      _login();
    },
    child: Container(
    width: double.infinity,
    height: 45,
    decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
    child: _isSigning ? CircularProgressIndicator(
    color: Colors.white,) : Text(
    "Login",
    style: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
    ),
    ),
    // SizedBox(height: 10,),
    // GestureDetector(
    // onTap: () {
    //   _login();
    //
    // },
    // child: Container(
    // width: double.infinity,
    // height: 45,
    // decoration: BoxDecoration(
    // color: Colors.red,
    // borderRadius: BorderRadius.circular(10),
    // ),
    // child: Center(
    // child: Row(
    // mainAxisAlignment: MainAxisAlignment.center,
    // children: [
    // Icon(FontAwesomeIcons.google, color: Colors.white,),
    // SizedBox(width: 5,),
    // Text(
    // "Sign in with Google",
    // style: TextStyle(
    // color: Colors.white,
    // fontWeight: FontWeight.bold,
    // ),
    // ),
    // ],
    // ),
    // ),
    // ),

    ],
    ),
        ),
        ),
    );
  }

  void _login() async {
    setState(() {
      _isSigning = true;
    });
    String email = _emailController.text;
    String password = _passwordController.text;

    // Query Firestore to check if the entered email and password exist
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Workers')
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get();

    setState(() {
      _isSigning = false;
    });

    // If there is a match, the user is logged in
    if (querySnapshot.docs.isNotEmpty) {
      showToast(message: "User is successfully signed in");
      String email = _emailController.text;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WorkersHome(email: email)),
      );      // Navigate to the home page or perform any action you want
      print('Login Successful');
      // Navigator.push(context, MaterialPageRoute(builder: (context) => WorkerProfilePage(email: email)));

    } else {
      showToast(message: "some error occured");

      // Display an error message or perform any action you want
      print('Invalid email or password');
    }

  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
