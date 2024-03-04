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
      body: SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                child: Center(
                child: Text('Container 1'),
              ),
              height: 250,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), // Border radius
              border: Border.all(
                color: Colors.black, // Border color
                width: 2.0, // Border width
              ),
                color: Colors.blue,
              ),
              ),
              SizedBox(height: 16.0),
              Container(
                child: Center(
                  child: Text('Container 2'),
                ),
                height: 250,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), // Border radius
                  border: Border.all(
                    color: Colors.black, // Border color
                    width: 2.0, // Border width
                  ),
                color: Colors.green,
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                child: Center(
                  child: Text('Container 3'),
                ),
                height: 250,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), // Border radius
                  border: Border.all(
                    color: Colors.black, // Border color
                    width: 2.0, // Border width
                  ),
                color: Colors.orange,
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                child: Center(
                  child: Text('Container 4'),
                ),
                height: 250,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), // Border radius
                  border: Border.all(
                    color: Colors.black, // Border color
                    width: 2.0, // Border width
                  ),
                color: Colors.red,
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                child: Center(
                  child: Text('Container 5'),
                ),
                height: 250,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), // Border radius
                  border: Border.all(
                    color: Colors.black, // Border color
                    width: 2.0, // Border width
                  ),
                color: Colors.purple,
                ),
              ),
            ],
            //
            // child:floatingActionButton: FloatingActionButton(
            //   child: const Icon(Icons.search),
            //   onPressed: () => showSearch(context: context, delegate: Search()),
            // ),
          ),
        ),
      ),
    );
  }
}



