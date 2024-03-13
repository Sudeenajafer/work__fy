import 'package:flutter/material.dart';
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