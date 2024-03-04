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
    FirstPage(),
    SecondPage(),
    ThirdPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('WorkiFy'),
        // style: TextStyle(color: Colors.black),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.comment),
            tooltip: 'Comment Icon',
            onPressed: () {},
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
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
  child: Container(
  padding: EdgeInsets.all(16.0),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(4.0),
          child: Text('  What are you looking for...',
            style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),),
          width: double.infinity,
          height: 40,
        ),
        SizedBox(height: 16.0),
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
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(4.0),
          child: Text('A plumber',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),),
          width: double.infinity,
          height: 30,
        ),
        SizedBox(height: 16.0),
        Container(
          height: 250,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(10.0), // Border radius
            border: Border.all(
              color: Colors.black, // Border color
            ),
          ),
          child: Image.network('https://i.ytimg.com/vi/GlzvfaiJqqg/maxresdefault.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: EdgeInsets.all(4.0),
          child: Text('An Electrician',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),),
          width: double.infinity,
          height: 30,
        ),
        SizedBox(height: 16.0),
        Container(
          height: 250,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(10.0), // Border radius
            border: Border.all(
              color: Colors.black, // Border color
            ),
          ),
          child: Image.network('https://clipartmag.com/images/mechanic-clipart-13.png',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(4.0),
          child: Text('A Mechanic',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),),
          width: double.infinity,
          height: 30,
        ),
        SizedBox(height: 16.0),
        Container(
          height: 250,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(10.0), // Border radius
            border: Border.all(
              color: Colors.black, // Border color
            ),
          ),
          child: Image.network('https://marketingkingss.online/wp-content/uploads/2021/04/GracefulShinyHeifer-max-1mb.gif',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(4.0),
          child: Text('A Painter',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),),
          width: double.infinity,
          height: 30,
        ),
        SizedBox(height: 16.0),
        Container(
          height: 250,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(10.0), // Border radius
            border: Border.all(
              color: Colors.black, // Border color
            ),
          ),
          child: Image.network('https://i.ytimg.com/vi/WlR1CqjVRJk/maxresdefault.jpg',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(4.0),
          child: Text('A Floor Cleaner',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),),
          width: double.infinity,
          height: 30,
        ),
      ],
      //
      // child:floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.search),
      //   onPressed: () => showSearch(context: context, delegate: Search()),
      // ),
    ),
  ),
);

        }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Available Services'),
    );
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Booking'),
    );
  }
}


//