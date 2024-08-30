import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';  // Import the intl package
import 'intro.dart';

class WorkersHome extends StatefulWidget {
  final String email;
  const WorkersHome({super.key, required this.email});

  @override
  _WorkersHomeState createState() => _WorkersHomeState();
}

class _WorkersHomeState extends State<WorkersHome> {
  int _currentIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      FirstPage(email: widget.email),
      WorkerProfilePage(email: widget.email),
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
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.blue,
        actions: <Widget>[
        ],
        automaticallyImplyLeading: false, // Disable the default leading behavior
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate to the specified page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Myintro(child: null,),
              ),
            );
          },
        ),
      ),
      body: _pages[_currentIndex],
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

  const FirstPage({super.key, required this.email});

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scheduled Tasks'),
        automaticallyImplyLeading: false,  // Removes the back arrow
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('bookings').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
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
              .whereType<Booking>()
              .toList();
          return ListView.builder(
            itemCount: userBookings.length,
            itemBuilder: (context, index) {
              final booking = userBookings[index];
              return NotificationContainer(
                booking: booking,
                onTap: () {
                  // Navigate to the new page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingDetailsPage(booking: booking),
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
  final Timestamp time;
  final String userEmail;
  bool isAccepted;
  bool isRejected;

  Booking({required this.workerName, required this.time, required this.userEmail, this.isAccepted = false, this.isRejected = false,});

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      workerName: map['firstname'] as String? ?? '',
      time: map['timestamp'] as Timestamp? ?? Timestamp.now(),  // Fetch timestamp
      userEmail: map['userEmail'] as String? ?? '',
    );
  }

  String get formattedTimestamp {
    DateTime dateTime = time.toDate();
    // Convert DateTime to original timestamp string format
    return DateFormat('MMMM d, yyyy at h:mm:ss a').format(dateTime);
  }
}

class NotificationContainer extends StatelessWidget {
  final Booking booking;
  final VoidCallback onTap;

  const NotificationContainer({super.key, required this.booking, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                Text('Date&Time: ${booking.formattedTimestamp}'),
                Text('User Email: ${booking.userEmail}'),
              ],
            ),
            const Icon(Icons.arrow_forward, color: Colors.blue),  // Replace the button with an arrow icon
          ],
        ),
      ),
    );
  }
}

class BookingDetailsPage extends StatefulWidget {
  final Booking booking;

  BookingDetailsPage({required this.booking});

  @override
  _BookingDetailsPageState createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  bool isActionTaken = false; // To track if Accept or Reject button was pressed
  bool isWorkDone = false; // To track if the Work Done button was pressed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Date & Time: ${widget.booking.formattedTimestamp}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('User Email: ${widget.booking.userEmail}', style: TextStyle(fontSize: 18)),
              ],
            ),
            if (!isActionTaken)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _showConfirmationDialog(context, 'Accept'),
                    child: Text('Accept'),
                  ),
                  ElevatedButton(
                    onPressed: () => _showConfirmationDialog(context, 'Reject'),
                    child: Text('Reject'),
                  ),
                ],
              )
            else if (!isWorkDone)
              ElevatedButton(
                onPressed: () => _markWorkAsDone(context),
                child: Text('Work Done'),
              ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, String action) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$action Booking'),
          content: Text('Are you sure you want to $action this booking?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                setState(() {
                  isActionTaken = true; // Show the Work Done button
                });

                // Show snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Booking ${action.toLowerCase()}ed!'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _markWorkAsDone(BuildContext context) {
    setState(() {
      isWorkDone = true;
    });

    // Show snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Work marked as done!'),
        duration: Duration(seconds: 1),
      ),
    );

    // Delete the booking from Scheduled Task page
    // This is where you would implement the logic to remove the booking

    Navigator.of(context).pop(); // Go back to the previous page after marking as done
  }
}

class WorkerProfilePage extends StatefulWidget {
  final String email;

  const WorkerProfilePage({super.key, required this.email});

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
        title: const Text('Worker Profile'),
        automaticallyImplyLeading: false,  // Removes the back arrow
      ),
      body: _workerDetails == null
          ? const Center(
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
            const SizedBox(height: 20),
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
              padding: const EdgeInsets.all(15.0),
              child:Text(
                'First Name: ${_workerDetails!['first_name']}',
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ), // Padding inside the container
            ),
            const SizedBox(height: 16.0),
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
              padding: const EdgeInsets.all(15.0),
              child:Text(
                'Last Name: ${_workerDetails!['last_name']}',
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ), // Padding inside the container
            ),
            const SizedBox(height: 16.0),
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
              padding: const EdgeInsets.all(15.0),
              child:Text(
                'Age: ${_workerDetails!['age']}',
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ), // Padding inside the container
            ),
            const SizedBox(height: 16.0),
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
              padding: const EdgeInsets.all(15.0),
              child:Text(
                'Location: ${_workerDetails!['location']}',
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ), // Padding inside the container
            ),
            const SizedBox(height: 16.0),
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
              padding: const EdgeInsets.all(15.0),
              child:Text(
                'Address: ${_workerDetails!['address']}',
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ), // Padding inside the container
            ),
            const SizedBox(height: 16.0),
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
              padding: const EdgeInsets.all(15.0),
              child:Text(
                'Email: ${_workerDetails!['email']}',
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ), // Padding inside the container
            ),
            const SizedBox(height: 16.0),
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
              padding: const EdgeInsets.all(15.0),
              child:Text(
                'Job: ${_workerDetails!['job']}',
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ), // Padding inside the container
            ),
            const SizedBox(height: 16.0),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
