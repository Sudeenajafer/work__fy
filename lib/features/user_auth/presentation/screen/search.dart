import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home.dart';
class search extends StatefulWidget {
  const search({super.key});
  @override
  State<search> createState() => _searchState();

}
class _searchState extends State<search> {
  final TextEditingController _textEditingController = TextEditingController();

  final List<Map<String, dynamic>> _allUsers = [
    {"name": "Painter"},
    {"name": "House keeper"},
    {"name": "Plumber"},
    {"name": "Electrician"},
    {"name": "Mechanic"},
    {"name": "Tutor"},
    {"name": "Baby Sitter"},
  ];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];

  @override
  initState() {
    _foundUsers = _allUsers;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
          user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _textEditingController,
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _textEditingController.clear();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                itemCount: _foundUsers.length,
                itemBuilder: (context, index) => Card(
                  key: ValueKey(_foundUsers[index]["name"]),
                  color: Colors.white,
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    title: Text(_foundUsers[index]['name'],
                        style: const TextStyle(color: Colors.black)),
                    onTap: () {
                      // Fetch worker data for the selected job from Firestore
                      String selectedJob = _foundUsers[index]["name"];
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
                  : const Text(
                'No results found',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WorkerDetailPage extends StatelessWidget {
  final String jobName;

  const WorkerDetailPage({required this.jobName});

  // get workerData => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workers for $jobName',
        style: TextStyle(fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Jobs')
            .doc(jobName)
            .collection('workers')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No workers found for $jobName'));
          } else {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic>? workerData = document.data() as Map<String, dynamic>?;
                // Use null-aware operators to handle null values
                if (workerData != null && workerData.containsKey('first_name') && workerData.containsKey('last_name')) {
                  String first_name = workerData['first_name'] ??
                      'Unknown'; // Use a default value if 'name' is null
                  String last_name = workerData['last_name'] ??
                      'Unknown'; // Use a default value if 'name' is null

                  return ListTile(
                      leading: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.person),
                        iconSize: 24,
                      ),
                      title: Text('$first_name $last_name',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),),
                      // subtitle: Text('Go to Gym at 6:00 AM'),
                      trailing: IconButton(
                        onPressed: () {
                          {
                            // Navigate to booking page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ThirdPage(
                                  firstname: workerData['first_name'] ?? '',
                                  email: workerData['email'] ?? '',
                                  phoneNumber: workerData['phone_number'] ?? '',
                                  location: workerData['location'] ?? '', workerId: '',
                                ),
                              ),
                            );
                          }                        },
                        icon: Icon(Icons.arrow_forward),
                        iconSize: 24,

                      )
                  );
                  // ListTile(
                  //   title: Text('Go to College'),
                  //   subtitle: Text('Go to College at 8:00 AM'),
                  // ),
                  // ListTile(
                  //   title: Text('Go to Office'),
                  //   subtitle: Text('Go to Office at 11:00 AM'),
                  // ),
                  // Add more ListTiles as needed

                  // title: Text('$first_name $last_name'),

                }
                else {
                  // Handle the case where firstname and/or lastname fields are missing
                  return ListTile(
                    title: Text('Missing Data'),
                  );
                }
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
