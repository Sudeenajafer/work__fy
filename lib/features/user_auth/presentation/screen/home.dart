import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../global/toast.dart';
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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.comment),
            tooltip: 'Comment Icon',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => commnet()));
            },
          ), //IconButton
          ],
      ),

      drawer: Drawer(
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
            label: 'Booking',
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

    return SingleChildScrollView(
  child: Container(
  padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
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
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Search..',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),              ),
                const Spacer(), // Spacer widget to push the icon button to the end of the row
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  iconSize: 20.0, // Set the icon size as per your requirement
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const search()));
                  },
                ),
              ],
            ),
          ),
        const SizedBox(height: 16.0),
        Container(
          height: 250,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(20.0), // Border radius
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
          ),
            child: Image.network('https://newvideomarketing.com/wp-content/uploads/2017/06/plumber_woman_animated.jpg',
              fit: BoxFit.cover,
            ),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(4.0),
          width: double.infinity,
          height: 60,
          child: Row(
            children: [
              const Text(
                'Plumber',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),              ),
              const Spacer(), // Spacer widget to push the icon button to the end of the row
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                iconSize: 20.0, // Set the icon size as per your requirement
                onPressed: () {
                },
              ),
            ],
          ),

        ),
        const SizedBox(height: 16.0),
        Container(
          height: 250,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(10.0), // Border radius
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
          ),
          child: Image.network('https://i.ytimg.com/vi/GlzvfaiJqqg/maxresdefault.jpg',
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(4.0),
          width: double.infinity,
          height: 60,
          child: Row(
            children: [
              const Text(
                'Electrician',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),              ),
              const Spacer(), // Spacer widget to push the icon button to the end of the row
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                iconSize: 20.0, // Set the icon size as per your requirement
                onPressed: () {
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          height: 250,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(10.0), // Border radius
            border: Border.all(
              color: Colors.black, // Border color
              width: 2.0,
            ),
          ),
          child: Image.network('https://clipartmag.com/images/mechanic-clipart-13.png',
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(4.0),
          width: double.infinity,
          height: 60,
          child: Row(
            children: [
              const Text(
                'Mechanic',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),              ),
              const Spacer(), // Spacer widget to push the icon button to the end of the row
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                iconSize: 20.0, // Set the icon size as per your requirement
                onPressed: () {
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          height: 250,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(10.0), // Border radius
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
          ),
          child: Image.network('http://pluspng.com/img-png/painting-png-painting-png-file-684.png',
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(4.0),
          width: double.infinity,
          height: 60,
          child: Row(
            children: [
              const Text(
                'Painter',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),              ),
              const Spacer(), // Spacer widget to push the icon button to the end of the row
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                iconSize: 20.0, // Set the icon size as per your requirement
                onPressed: () {
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          height: 250,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(10.0), // Border radius
            border: Border.all(
              color: Colors.black, // Border color
              width: 2.0,
            ),
          ),
          child: Image.network('https://i.ytimg.com/vi/WlR1CqjVRJk/maxresdefault.jpg',
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(4.0),
          width: double.infinity,
          height: 60,
          child: Row(
            children: [
              const Text(
                'House Keeping',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),              ),
              const Spacer(), // Spacer widget to push the icon button to the end of the row
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                iconSize: 20.0, // Set the icon size as per your requirement
                onPressed: () {
                },
              ),
            ],
          ),
        ),
      ],
      //

    ),
  ),
    //     child:floatingActionButton: FloatingActionButton(
    // child: const Icon(Icons.search),
    // onPressed: () => showSearch(context: context, delegate: Search()),
    // ),
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
        title: const Text('Booking'),
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => FourthPage( firstname: '', email: '',phoneNumber: '', location: '',)));
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
                            // Perform cancel booking operation
                            // Display message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Booking cancelled')),
                            );
                            Navigator.pushNamed(context, "/home");
                          },
                          child: Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
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

class commnet extends StatelessWidget {
  const commnet({super.key});


  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No notifivation yet..'),
    );
  }
}
