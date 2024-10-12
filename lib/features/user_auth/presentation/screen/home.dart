import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    FourthPage( email: ''),
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

class FourthPage extends StatefulWidget {
  final String email;

  FourthPage({required this.email});

  @override
  _FourthPageState createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  List<Booking> _userBookings = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserBookings();
  }

  Future<void> _fetchUserBookings() async {
    try {
      QuerySnapshot bookingsSnapshot = await FirebaseFirestore.instance.collection('bookings').get();

      List<Booking> bookings = [];

      for (QueryDocumentSnapshot bookingDoc in bookingsSnapshot.docs) {
        // Fetch all documents in the subcollection for each bookingId
        QuerySnapshot subCollectionSnapshot = await bookingDoc.reference.collection('subcollection').get();

        for (QueryDocumentSnapshot subDoc in subCollectionSnapshot.docs) {
          if (subDoc['userEmail'] == widget.email) {
            bookings.add(Booking.fromMap(subDoc.data() as Map<String, dynamic>));
          }
        }
      }

      setState(() {
        _userBookings = bookings;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching bookings: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Bookings'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _userBookings.isEmpty
          ? const Center(child: Text('No bookings found'))
          : ListView.builder(
        itemCount: _userBookings.length,
        itemBuilder: (context, index) {
          final booking = _userBookings[index];
          return NotificationContainer(
            booking: booking,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingDetailsPage(booking: booking),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Booking {
  final String firstname;
  final String location;
  final String email;
  final Timestamp time;

  Booking({
    required this.firstname,
    required this.location,
    required this.email,
    required this.time,
  });

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      firstname: map['firstname'] as String? ?? '',
      location: map['location'] as String? ?? '',
      email: map['userEmail'] as String? ?? '',
      time: map['timestamp'] as Timestamp? ?? Timestamp.now(),
    );
  }

  String get formattedTimestamp {
    DateTime dateTime = time.toDate();
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
                Text('Worker Name: ${booking.firstname}'),
                Text('Location: ${booking.location}'),
                Text('User Email: ${booking.email}'),
                Text('Date & Time: ${booking.formattedTimestamp}'),
              ],
            ),
            const Icon(Icons.arrow_forward, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}

class BookingDetailsPage extends StatelessWidget {
  final Booking booking;

  BookingDetailsPage({required this.booking});

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
                Text('Worker Name: ${booking.firstname}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('Location: ${booking.location}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('User Email: ${booking.email}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('Date & Time: ${booking.formattedTimestamp}', style: TextStyle(fontSize: 18)),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                await _cancelBooking(context, booking);
              },
              child: Text('Cancel Booking'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _cancelBooking(BuildContext context, Booking booking) async {
    try {
      QuerySnapshot bookingsSnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .where('userEmail', isEqualTo: booking.email)
          .get();

      for (QueryDocumentSnapshot bookingDoc in bookingsSnapshot.docs) {
        QuerySnapshot subCollectionSnapshot = await bookingDoc.reference.collection('subcollection').get();
        for (QueryDocumentSnapshot subDoc in subCollectionSnapshot.docs) {
          if (subDoc['userEmail'] == booking.email) {
            await subDoc.reference.delete();
          }
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking canceled successfully')),
      );
      Navigator.pop(context);
    } catch (e) {
      print('Error canceling booking: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error canceling booking')),
      );
    }
  }
}
