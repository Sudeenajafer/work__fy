// import "package:carousel_slider/carousel_slider.dart";
import 'package:flutter/material.dart';
import 'search.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[900],
      appBar: AppBar(
        title: const Text('WorkiFy',
         style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey,
          // leading: IconButton(
          //   icon: const Icon(
          //     Icons.notifications_none,
          //     color: Colors.black,
          //   ),
          //   onPressed: () {  },
          // ),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children:  const <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('User Name'),
              accountEmail: Text('user@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text('U'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
            ),          ],
        ),
      ),
        body:const SingleChildScrollView(
                           child: Text('WorkiFy',
                            style: TextStyle(color: Colors.black),
                          )
                        ),


          floatingActionButton: FloatingActionButton(
             child: const Icon(Icons.search),
              onPressed: () => showSearch(context: context, delegate: Search()),
    ),



    );
  }
}