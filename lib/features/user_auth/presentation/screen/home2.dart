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
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => WorkerProfilePage(email: widget.email))
              // );
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scheduled Tasks'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('bookings').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = snapshot.data!.docs;
          final userBookings = docs
              .where((doc) => doc['email'] == widget.email)
              .map((doc) {
            final data = doc.data();
            if (data != null) {
              return Booking.fromMap(data as Map<String, dynamic>);
            } else {
              return null;
            }
          })
              .whereType<Booking>() // Remove null elements
              .toList();
          return ListView.builder(
            itemCount: userBookings.length,
            itemBuilder: (context, index) {
              final booking = userBookings[index];
              return NotificationContainer(
                booking: booking,
                onAccept: () {
                  // Fetch details from subcollection and navigate to BookingDetailsPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingDetailsPage(email: widget.email, booking: booking),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class Booking {
  final String workerName;
  final String time;
  final String userEmail; // Add user's email who booked the service

  Booking({required this.workerName, required this.time, required this.userEmail});

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      workerName: map['workerName'] as String? ?? '',
      time: map['time'] as String? ?? '',
      userEmail: map['email'] as String? ?? '', // Fetch user's email who booked the service
    );
  }
}

class NotificationContainer extends StatelessWidget {
  final Booking booking;
  final VoidCallback onAccept;

  NotificationContainer({required this.booking, required this.onAccept});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Worker: ${booking.workerName}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Time: ${booking.time}'),
            ],
          ),
          ElevatedButton(
            onPressed: onAccept,
            child: Text('Accept'),
          ),
        ],
      ),
    );
  }
}

class BookingDetailsPage extends StatefulWidget {
  final String email;
  final Booking booking;

  const BookingDetailsPage({Key? key, required this.email, required this.booking}) : super(key: key);

  @override
  _BookingDetailsPageState createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  Map<String, dynamic>? _bookingDetails;

  @override
  void initState() {
    super.initState();
    _fetchBookingDetails();
  }

  Future<void> _fetchBookingDetails() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .doc(widget.booking.userEmail) // Assuming user's email is used as document ID in subcollection
          .collection('details')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          _bookingDetails = querySnapshot.docs.first.data() as Map<String, dynamic>?;
        });
      }
    } catch (e) {
      print('Error fetching booking details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
      ),
      body: _bookingDetails == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Email: ${_bookingDetails!['email']}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'User First Name: ${_bookingDetails!['firstname']}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Timestamp: ${_bookingDetails!['timestamp']}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            // Add more details as needed
          ],
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