import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home2.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedJob = '-<select>-';

  final List<String> _jobList = [
 '-<select>-',
    'Plumber',
    'Painter',
    'Mechanic',
    'House Keeper',
    'Tutor',
    'Baby Sitter',
    'Electrician',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(labelText: 'First Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your age';
                    } else {
                      int? age = int.tryParse(value);
                      if (age == null || age <= 18) {
                        return 'Age must be greater than 18';
                      }
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(labelText: 'Location'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your location';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField(
                  value: _selectedJob,
                  items: _jobList.map((job) {
                    return DropdownMenuItem(
                      value: job,
                      child: Text(job),
                    );
                  }).toList(),
                  hint: const Text('Select a Job'),
                  onChanged: (value) {
                    setState(() {
                      _selectedJob = value!;
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Job'),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a job';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _register();
                    }
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _register() {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    int age = int.parse(_ageController.text);
    String email = _emailController.text;
    String location = _locationController.text;
    String address = _addressController.text;
    String password = _passwordController.text;

    // Add data to Firestore
    FirebaseFirestore.instance.collection('Workers').add({
      'first_name': firstName,
      'last_name': lastName,
      'age': age,
      'email': email,
      'location': location,
      'address': address,
      'password': password,
      'job': _selectedJob,
    }).then((value) {
      // If job is selected, add data to corresponding subcollection
      FirebaseFirestore.instance
          .collection('Jobs')
          .doc(_selectedJob)
          .collection('workers')
          .add({
        'first_name': firstName,
        'last_name': lastName,
        'age': age,
        'email': email,
        'location': location,
        'address': address,
        'password': password,
      });
    });
    _formKey.currentState?.reset();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Registration Successful'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => WorkersHome()));
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

