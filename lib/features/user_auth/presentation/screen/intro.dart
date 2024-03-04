
import 'package:flutter/material.dart';
// import 'register.dart';
 import 'login.dart';

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
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.all(20),
              padding: EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.blueAccent,
              ),
              width: double.infinity,
              height: 200,
              child :Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 const Text(
                  'EMPLOYEES PORTAL',
                  style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),
                ),
                  const Spacer(), // Adds empty space to push the button to the bottom
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  LoginPage(),
                          ),
                        );
                      },
                      child: const Text('Register'),
                    ),
                  ),
],
              ),
            ),

            const SizedBox(height: 20), // Add some space between the containers
            Container(
              margin: const EdgeInsets.all(20),
              padding: EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.blueAccent,
              ),
              width: double.infinity,
              height: 200,

              // alignment: Alignment.topLeft,

              child :Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // alignment: Alignment.topLeft,

                  const Text(
                    'HIRING PORTAL',
                    style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),
                  ),

                  const Spacer(), // Adds empty space to push the button to the bottom
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      child: const Text('Login '),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

