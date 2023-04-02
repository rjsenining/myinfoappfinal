import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('users');

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: usersCollection.doc(user!.uid).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final userData =
          snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'My Information',
                    style: TextStyle(
                        fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 8.0),
                    Text(
                      'Name: ${userData['name']}',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Icon(Icons.cake),
                    SizedBox(width: 8.0),
                    Text(
                      'Age: ${userData['age']}',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Icon(Icons.location_pin),
                    SizedBox(width: 8.0),
                    Text(
                      'Address: ${userData['address']}',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Icon(Icons.person_pin),
                    SizedBox(width: 8.0),
                    Text(
                      'Nickname: ${userData['nickname']}',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Icon(Icons.school),
                    SizedBox(width: 8.0),
                    Text(
                      'School: ${userData['school']}',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Icon(Icons.favorite),
                    SizedBox(width: 8.0),
                    Text(
                      'Hobbies: ${userData['hobbies']}',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Icon(Icons.accessibility),
                    SizedBox(width: 8.0),
                    Text(
                      'Gender: ${userData['gender']}',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}
