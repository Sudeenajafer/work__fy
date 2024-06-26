import 'package:flutter/material.dart';
import 'intro.dart';
// import 'signup.dart';

class Mysplash extends StatefulWidget {
  const Mysplash({super.key, required child});
  @override
  State<Mysplash> createState() => _MysplashState();
}
class _MysplashState extends State<Mysplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Container(
              width: 100,
              height: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'WF',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Myintro(child: null,)),
                  );
                }
            ),
          ),
        ],
      ),
    );

  }
}

