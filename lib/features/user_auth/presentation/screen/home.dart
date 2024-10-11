import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../global/toast.dart';
import 'intro.dart';
import 'search.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // List of pages to navigate to
  final List<Widget> _pages = [
    const FirstPage(),
    SecondPage(),
    YourBookingsPage( email: ''),
  ];

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
        actions: <Widget>[],
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

      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text('User Name'),
              accountEmail: Text('user@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text('U'),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('signOut'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, "/login");
                showToast(message: "Successfully signed out");
              },
            ),          ],
        ),
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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Available Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Bookings',
          ),
        ],
      ),
    );
  }
}
class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Animated Images Carousel
              SizedBox(
                height: 200,
                child: PageView(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, // Change color as needed
                          width: 3.0,          // Change border width as needed
                        ),
                      ),
                      child: Image.asset(
                        'assets/images/Easy to find (2).png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 3.0,
                        ),
                      ),
                      child: Image.asset(
                        'assets/images/Easy to find.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 3.0,
                        ),
                      ),
                      child: Image.asset(
                        'assets/images/Easy to find (1).png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              // Services Heading
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Deals & Offers',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Deals Horizontal Scroll
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    DealCard(text: '10% Discount on First Booking'),
                    DealCard(text: 'Express Service'),
                    DealCard(text: 'Peak Hour Discounts'),
                    DealCard(text: 'No Hidden Charges'),
                    DealCard(text: 'Free Cancellation'),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              // Services Heading
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Services',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Services Grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                children: [
                  ServiceCard(
                    title: 'Painter',
                    imageUrl:
                    'https://pluspng.com/img-png/painting-png-painting-png-file-684.png',
                    onTap: () {
                      // Navigate to Painter page
                    },
                  ),
                  ServiceCard(
                    title: 'House Keeper',
                    imageUrl:
                    'https://i.ytimg.com/vi/WlR1CqjVRJk/maxresdefault.jpg',
                    onTap: () {
                      // Navigate to House Keeper page
                    },
                  ),
                  ServiceCard(
                    title: 'Plumber',
                    imageUrl:
                    'https://cdn2.vectorstock.com/i/1000x1000/55/36/cartoon-plumber-repairing-a-pipe-vector-26985536.jpg',
                    onTap: () {
                      // Navigate to Plumber page
                    },
                  ),
                  ServiceCard(
                    title: 'Electrician',
                    imageUrl:
                    'https://cdn4.vectorstock.com/i/1000x1000/19/53/cartoon-electrician-cable-man-vector-29651953.jpg',
                    onTap: () {
                      // Navigate to Electrician page
                    },
                  ),
                  ServiceCard(
                    title: 'Mechanic',
                    imageUrl:
                    'https://as2.ftcdn.net/v2/jpg/05/69/90/77/1000_F_569907763_6JSDpoAAeyBjjyuP1eJWcfZ34aItK17U.jpg',
                    onTap: () {
                      // Navigate to Mechanic page
                    },
                  ),
                  ServiceCard(
                    title: 'Tutor',
                    imageUrl:
                    'https://thumbs.dreamstime.com/b/english-language-arts-tutor-isolated-cartoon-vector-illustration-creative-writing-teacher-reading-comprehension-student-266155250.jpg',
                    onTap: () {
                      // Navigate to Tutor page
                    },
                  ),
                  ServiceCard(
                    title: 'Baby Sitter',
                    imageUrl:
                    'https://c8.alamy.com/comp/2PT3PA9/babysitter-or-nanny-services-to-care-for-provide-for-baby-needs-and-play-with-children-on-flat-cartoon-hand-drawn-template-illustration-2PT3PA9.jpg',
                    onTap: () {
                      // Navigate to Baby Sitter page
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DealCard extends StatelessWidget {
  final String text;

  const DealCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(12.0)),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              alignment: Alignment.center,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Page'),
      ),
      body: const Center(
        child: Text('Search Functionality Here'),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final List<String> services = [
    'Painter',
    'House Keeper',
    'Plumber',
    'Electrician',
    'Mechanic',
    'Tutor',
    'Baby Sitter',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Services',
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,  // Removes the back arrow

      ),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) => Card(
          key: ValueKey(services[index]),
          color: Colors.white,
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            title: Text(services[index],
                style: const TextStyle(color: Colors.black)),
            onTap: () {
              // Fetch worker data for the selected job from Firestore
              String selectedJob = services[index];
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WorkerDetailPage(
                    jobName: selectedJob,
                  ),
                ),
              );
            },
          ),
        ),
      )
    );
  }
}




class ThirdPage extends StatelessWidget {
  final String firstname;
  final String email;
  final String phoneNumber;
  final String location;
  final String workerId;

  ThirdPage({required this.phoneNumber, required this.location, required this.firstname, required this.email, required this.workerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings',
        style: TextStyle(fontSize: 30),),
      centerTitle: false,
        automaticallyImplyLeading: false,  // Removes the back arrow
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // padding: const EdgeInsets.all(4.0),
              width: double.infinity,
              height: 30,
              child: const Text(
                'Worker Details:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Worker Location:',
              style: TextStyle(fontSize: 24,),
            ),
            SizedBox(height: 5),
            Text(location,style: TextStyle(fontSize: 24,),),
            SizedBox(height: 20),
            Text(
              'Worker Phone Number:',
              style: TextStyle(fontSize: 24,),
            ),
            SizedBox(height: 5),
            Text(phoneNumber,style: TextStyle(fontSize: 24,),),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
            child: ElevatedButton(
              onPressed: () async {
                _bookNow(context);
                await _makeBooking();
              },
              child: Text('Book now',style: TextStyle(fontSize: 24,),),
            ),
        ),
    );
  }
  void _bookNow(BuildContext context) {
    // Perform booking logic here
    // For example, show a dialog confirming the booking
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Booking Successful'),
        content: Text('Your booking has been confirmed.'),
        actions: [
          TextButton(
            onPressed: () {
              // Perform cancel booking operation and navigate to FirstPage
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                    (Route<dynamic> route) => false,
              );
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _makeBooking() async {
    try {
      // Get current user's email from FirebaseAuth
      String userEmail = FirebaseAuth.instance.currentUser!.email!;

      // Add booking data to Firestore
      await FirebaseFirestore.instance.collection('bookings').add({
        'firstname': firstname,
        'email': email,
        'phoneNumber': phoneNumber,
        'location': location,
        'userEmail': userEmail, // Add current user's email
        'timestamp': Timestamp.now(),
      });
    } catch (e) {
      // Handle error
      print('Error making booking: $e');
    }
  }

}

// class FourthPage extends StatelessWidget {
//   final String email;
//
//   FourthPage({required this.email});

class YourBookingsPage extends StatefulWidget {
  final String email; // The current user's email
  const YourBookingsPage({super.key, required this.email});

  @override
  _YourBookingsPageState createState() => _YourBookingsPageState();
}

class _YourBookingsPageState extends State<YourBookingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Bookings'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('bookings').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          // Filter bookings by checking if userEmail exists in the document
          final bookings = snapshot.data!.docs.where((doc) {
            final data = doc.data() as Map<String, dynamic>?;
            return data != null && data.containsKey('userEmail') && data['userEmail'] == widget.email;
          }).toList();

          if (bookings.isEmpty) {
            return const Center(child: Text('No bookings found.'));
          }

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final bookingData = bookings[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(bookingData['firstname'] ?? 'No Name'),
                subtitle: Text(
                  'Booked on: ${DateTime.fromMillisecondsSinceEpoch(bookingData['timestamp'].millisecondsSinceEpoch).toString()}',
                ),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingDetailsPage(
                        bookingId: bookings[index].id,
                        bookingData: bookingData,
                      ),
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

class BookingDetailsPage extends StatelessWidget {
  final String bookingId;
  final Map<String, dynamic> bookingData;

  const BookingDetailsPage({super.key, required this.bookingId, required this.bookingData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${bookingData['firstname']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Phone: ${bookingData['phonenumber']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Location: ${bookingData['location']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Email: ${bookingData['email']}', style: const TextStyle(fontSize: 18)),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                _showCancelDialog(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancel Booking'),
          content: const Text('Are you sure you want to cancel the booking?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog, stay on the page
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('bookings')
                    .doc(bookingId)
                    .delete(); // Delete the booking

                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Return to the previous page
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('The booking is canceled')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
