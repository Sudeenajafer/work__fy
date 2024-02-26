
import 'package:flutter/material.dart';
//import 'home.dart';
// import 'signup.dart';

class Myintro extends StatefulWidget {
  const Myintro({super.key, required child});
  @override
  State<Myintro> createState() => _MyintroState();
}
class _MyintroState extends State<Myintro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.blueAccent,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(30),
                child: const Text(
                    'WORKERS HIRING PORTAL',
                    style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),
                  ),
            ),
            const SizedBox(height: 20), // Add some space between the containers
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.blueAccent,
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(30),
              child: const Text(
                  'WORKERS FINDING PORTAL',
                  style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

