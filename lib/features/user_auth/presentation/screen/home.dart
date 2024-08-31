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
    ThirdPage(phoneNumber: '', location: '', firstname: '', email: '', workerId: '',),
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
                  children: [
                    Image.network(
                      'https://www.canva.com/design/DAGPchsntEE/WsV6u68ck_Gln3Xd76kMzQ/view?utm_content=DAGPchsntEE&utm_campaign=designshare&utm_medium=link&utm_source=editor',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'assets/images/image2.png',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'assets/images/image3.png',
                      fit: BoxFit.cover,
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
                    'https://newvideomarketing.com/wp-content/uploads/2017/06/plumber_woman_animated.jpg',
                    onTap: () {
                      // Navigate to Plumber page
                    },
                  ),
                  ServiceCard(
                    title: 'Electrician',
                    imageUrl:
                    'https://i.ytimg.com/vi/GlzvfaiJqqg/maxresdefault.jpg',
                    onTap: () {
                      // Navigate to Electrician page
                    },
                  ),
                  ServiceCard(
                    title: 'Mechanic',
                    imageUrl:
                    'https://clipartmag.com/images/mechanic-clipart-13.png',
                    onTap: () {
                      // Navigate to Mechanic page
                    },
                  ),
                  ServiceCard(
                    title: 'Tutor',
                    imageUrl:
                    'https://via.placeholder.com/150.png?text=Tutor+Image',
                    onTap: () {
                      // Navigate to Tutor page
                    },
                  ),
                  ServiceCard(
                    title: 'Baby Sitter',
                    imageUrl:
                    'https://via.placeholder.com/150.png?text=Baby+Sitter+Image',
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
class FourthPage extends StatelessWidget {
  final String firstname;
  final String email;
  final String phoneNumber;
  final String location;

  FourthPage({required this.phoneNumber, required this.location, required this.firstname, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking'),
        automaticallyImplyLeading: false, // Disable the default leading behavior
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate to the specified page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FirstPage(),
              ),
            );
          },
        ),
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
            Text(location, style: TextStyle(fontSize: 24,),),
            SizedBox(height: 20),
            Text(
              'Worker Phone Number:',
              style: TextStyle(fontSize: 24,),
            ),
            SizedBox(height: 5),
            Text(phoneNumber, style: TextStyle(fontSize: 24,),),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                // Handle cancelling booking
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Cancel Booking'),
                      content: Text('Are you sure you want to cancel the booking?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Perform cancel booking operation and navigate to FirstPage
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Booking cancelled')),
                            );
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                                  (Route<dynamic> route) => false,
                            );
                          },
                          child: Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Just navigate back to FirstPage without cancelling
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                                  (Route<dynamic> route) => false,
                            );
                          },
                          child: Text('No'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Cancel Booking'),
            ),
          ],
        ),
      ),
    );
  }
}