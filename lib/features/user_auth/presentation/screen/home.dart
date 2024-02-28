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
      body:SingleChildScrollView(
        child: Column(
          children: [
            WorkerCard(
              image: 'assets/plumber.png',
              name: 'John the Plumber',
              profession: 'Plumbing Expert',
            ),
            WorkerCard(
              image: 'assets/electrician.png',
              name: 'Emma the Electrician',
              profession: 'Electrical Specialist',
            ),
            // Add more WorkerCard widgets for other workers
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: () => showSearch(context: context, delegate: Search()),
      ),

    );
  }
}
        class WorkerCard extends StatelessWidget {
    final String image;
    final String name;
    final String profession;

    WorkerCard({required this.image, required this.name, required this.profession});

    @override
    Widget build(BuildContext context) {
    return Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
    color: Colors.grey[200],
    borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
    children: [
    Image.asset(image, height: 100),
    SizedBox(height: 10),
    Text(
    name,
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    Text(
    profession,
    style: TextStyle(fontSize: 14, color: Colors.grey),
    ),
    ],
    ),
    );
    }
    }
