import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkersHome extends StatefulWidget {
  final String email;
  const WorkersHome({Key? key, required this.email,}) : super(key: key);

  @override
  _WorkersHomeState createState() => _WorkersHomeState();

}
class _WorkersHomeState extends State<WorkersHome> {
  int _currentIndex = 0;
  late List<Widget> _pages;
  // List of pages to navigate to
  @override
  void initState() {
    super.initState();
    _pages = [
      FirstPage(email: widget.email,),
      WorkerProfilePage(email: widget.email,),
    ];
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('WorkiFy',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            )),
        // ,
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.comment),
            tooltip: 'Comment Icon',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WorkerProfilePage(email: widget.email))
              );
            },

          ), //IconButton
        ],
      ),
      body:_pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Scheduled Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}



class FirstPage extends StatefulWidget {
  final String email;
  const FirstPage({Key? key, required this.email}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool isBooked = false; // Flag to track if user is booked

  @override
  void initState() {
    super.initState();
    // Listen for changes in the 'bookings' collection
    FirebaseFirestore.instance.collection('bookings').snapshots().listen((snapshot) {
      // Check if current user's phone number is in the bookings
      String currentUserPhoneNumber = ''; // Replace with current user's phone number
      setState(() {
        isBooked = snapshot.docs.any((doc) => doc['phoneNumber'] == currentUserPhoneNumber);
      });
      if (isBooked) {
        print('You have a scheduled task.'); // Print message if user is booked
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Task'),
      ),
      body: Center(
        child: Text(
          isBooked ? 'You have a scheduled task.' : 'No scheduled task found.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
  
class WorkerProfilePage extends StatefulWidget {
  final String email;

  const WorkerProfilePage({Key? key, required this.email}) : super(key: key);

  @override
  _WorkerProfilePageState createState() => _WorkerProfilePageState();
}

class _WorkerProfilePageState extends State<WorkerProfilePage> {
  Map<String, dynamic>? _workerDetails;

  @override
  void initState() {
    super.initState();
    _fetchWorkerDetails();
  }

  Future<void> _fetchWorkerDetails() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Workers')
        .where('email', isEqualTo: widget.email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      setState(() {
        _workerDetails = querySnapshot.docs.first.data() as Map<String, dynamic>?;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Worker Profile'),
      ),
      body: _workerDetails == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.account_circle),
                  iconSize: 100,
                )
            ),
            SizedBox(height: 20),
            Container(
              height: 60,
              width: double.infinity,
              // color: Colors.white,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Border color
                  width: 2.0, // Border width
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child:Text(
                'First Name: ${_workerDetails!['first_name']}',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              padding: EdgeInsets.all(15.0), // Padding inside the container
            ),
            SizedBox(height: 16.0),
            Container(
              height: 60,
              width: double.infinity,
              // color: Colors.white,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Border color
                  width: 2.0, // Border width
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child:Text(
                'Last Name: ${_workerDetails!['last_name']}',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              padding: EdgeInsets.all(15.0), // Padding inside the container
            ),
            SizedBox(height: 16.0),
            Container(
              height: 60,
              width: double.infinity,
              // color: Colors.white,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Border color
                  width: 2.0, // Border width
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child:Text(
                'Age: ${_workerDetails!['age']}',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              padding: EdgeInsets.all(15.0), // Padding inside the container
            ),
            SizedBox(height: 16.0),
            Container(
              height: 60,
              width: double.infinity,
              // color: Colors.white,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Border color
                  width: 2.0, // Border width
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child:Text(
                'Location: ${_workerDetails!['location']}',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              padding: EdgeInsets.all(15.0), // Padding inside the container
            ),
            SizedBox(height: 16.0),
            Container(
              height: 60,
              width: double.infinity,
              // color: Colors.white,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Border color
                  width: 2.0, // Border width
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child:Text(
                'Address: ${_workerDetails!['address']}',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              padding: EdgeInsets.all(15.0), // Padding inside the container
            ),
            SizedBox(height: 16.0),
            Container(
              height: 60,
              width: double.infinity,
              // color: Colors.white,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Border color
                  width: 2.0, // Border width
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child:Text(
                'Email: ${_workerDetails!['email']}',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              padding: EdgeInsets.all(15.0), // Padding inside the container
            ),
            SizedBox(height: 16.0),
            Container(
              height: 60,
              width: double.infinity,
              // color: Colors.white,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Border color
                  width: 2.0, // Border width
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child:Text(
                'Job: ${_workerDetails!['job']}',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              padding: EdgeInsets.all(15.0), // Padding inside the container
            ),
            SizedBox(height: 16.0),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}