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
      body:_pages[_currentIndex],
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
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
  child: Container(
  padding: EdgeInsets.all(16.0),
    child: Column(
      children: [
        GestureDetector(
        onTap: () {
      // Navigate to the next page
            Navigator.push(context, MaterialPageRoute(builder: (context) => search()));
         },
        child: Container(
          padding: EdgeInsets.all(2.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey), // Border color
            ),
          child: Row(
            children: [
              // IconButton(
              //   icon: Icon(Icons.arrow_back),
              //   onPressed: () {
              //   },
              // ),
              // SizedBox(width: 8.0), // Adjust spacing between items
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search here...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // Handle search icon pressed
                  // You can customize this action
                },
              ),
              IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  // Handle clear icon pressed
                  // You can customize this action
                },
              ),
            ],
          ),
          // child: Text('search here...',
          //   style: TextStyle(
          //   fontSize: 20,
          //   fontWeight: FontWeight.w900,
          // ),),
          width: double.infinity,
          height: 40,
        ),
        ),
        SizedBox(height: 16.0),
        // GestureDetector(
        //   onTap: ()  => showSearch(context: context, delegate: Search()),
        //   child: Container(
        //     padding: EdgeInsets.all(16.0),
        //     child: Row(
        //       children: [
        //         IconButton(
        //           icon: Icon(Icons.arrow_back),
        //           onPressed: () {
        //             // Handle back button action
        //             Navigator.pop(context);
        //           },
        //         ),
        //         Expanded(
        //           child: TextField(
        //             controller: _searchController,
        //             decoration: InputDecoration(
        //               hintText: 'Search...',
        //               border: OutlineInputBorder(),
        //             ),
        //           ),
        //         ),
        //         IconButton(
        //           icon: Icon(Icons.clear),
        //           onPressed: () {
        //             // Clear the search text
        //             _searchController.clear();
        //           },
        //         ),
        //         IconButton(
        //           icon: Icon(Icons.search),
        //           onPressed: () {
        //             // Handle search button action
        //             // You can use _searchController.text for the search query
        //             print('Search: ${_searchController.text}');
        //           },
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // SizedBox(height: 16.0),
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
          width: double.infinity,
          height: 30,
          child: Row(
            children: [
              Text(
                'Plumber',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),              ),
              Spacer(), // Spacer widget to push the icon button to the end of the row
              IconButton(
                icon: Icon(Icons.arrow_forward),
                iconSize: 20.0, // Set the icon size as per your requirement
                onPressed: () {
                },
              ),
            ],
          ),

        ),
        SizedBox(height: 16.0),
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
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(4.0),
          width: double.infinity,
          height: 30,
          child: Row(
            children: [
              Text(
                'Electrician',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),              ),
              Spacer(), // Spacer widget to push the icon button to the end of the row
              IconButton(
                icon: Icon(Icons.arrow_forward),
                iconSize: 20.0, // Set the icon size as per your requirement
                onPressed: () {
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
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
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(4.0),
          width: double.infinity,
          height: 30,
          child: Row(
            children: [
              Text(
                'Mechanic',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),              ),
              Spacer(), // Spacer widget to push the icon button to the end of the row
              IconButton(
                icon: Icon(Icons.arrow_forward),
                iconSize: 20.0, // Set the icon size as per your requirement
                onPressed: () {
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
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
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(4.0),
          width: double.infinity,
          height: 30,
          child: Row(
            children: [
              Text(
                'Painter',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),              ),
              Spacer(), // Spacer widget to push the icon button to the end of the row
              IconButton(
                icon: Icon(Icons.arrow_forward),
                iconSize: 20.0, // Set the icon size as per your requirement
                onPressed: () {
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
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
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(4.0),
          width: double.infinity,
          height: 30,
          child: Row(
            children: [
              Text(
                'House Keeping',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),              ),
              Spacer(), // Spacer widget to push the icon button to the end of the row
              IconButton(
                icon: Icon(Icons.arrow_forward),
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