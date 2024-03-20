import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Worker {
  final String name;
  final String description; // Add more fields as needed

  Worker({required this.name, required this.description});

  factory Worker.fromMap(Map<String, dynamic> map) {
    return Worker(
      name: map['name'],
      description: map['description'],
    );
  }
}

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Worker?> getWorkerByName(String jobName, String workerName) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('Jobs')
          .doc(jobName)
          .collection('workers')
          .doc(workerName)
          .get();
      if (doc.exists) {
        return Worker.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print("Error fetching worker: $e");
      return null;
    }
  }
}


class WorkerDetailPage extends StatelessWidget {
  final String jobName;
  final String workerName;
  final FirestoreService _firestoreService = FirestoreService();

  WorkerDetailPage({required this.jobName,required this.workerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(workerName),
      ),
      body: FutureBuilder(
        future: _firestoreService.getWorkerByName(jobName,workerName),
        builder: (context, AsyncSnapshot<Worker?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final Worker? worker = snapshot.data;
          if (worker == null) {
            return Center(child: Text('Worker data not found.'));
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  worker.description,
                  style: TextStyle(fontSize: 16),
                ),
                // Add more fields as needed
              ],
            ),
          );
        },
      ),
    );
  }
}

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);
  @override
  State<search> createState() => _searchState();

}

class _searchState extends State<search> {
  TextEditingController _textEditingController = TextEditingController();

  final List<Map<String, dynamic>> _allUsers = [
    {"name": "Painter"},
    {"name": "House keeper"},
    {"name": "Plumber"},
    {"name": "Electrician"},
    {"name": "Mechanic"},
    {"name": "Tutor"},
    {"name": "Baby sitter"},
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
    setState((){
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
                labelText: 'Search', suffixIcon:Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _textEditingController.clear();
                      });                  },
                  ),
                ],
              ),),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                itemCount: _foundUsers.length,
                itemBuilder: (context, index) =>
                    Card(
                      key: ValueKey(_foundUsers[index]["name"]),
                      color: Colors.white,
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        // leading: Text(
                        //   _foundUsers[index]["id"].toString(),
                        //   style: const TextStyle(
                        //       fontSize: 24, color: Colors.white),
                        // ),
                        title: Text(_foundUsers[index]['name'], style: TextStyle(
                            color: Colors.black
                        )),
                        onTap: () {
                          // Navigate to worker's page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WorkerDetailPage(jobName:_allUsers[index]["name"],workerName: _foundUsers[index]["name"],
                              ),
                            ),
                          );
                        },
                        // subtitle: Text(
                        //     '${_foundUsers[index]["age"].toString()} years old',
                        //     style: TextStyle(
                        //         color: Colors.white
                        //     )),
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
