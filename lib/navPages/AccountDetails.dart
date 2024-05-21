import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/login/UpdatePassword.dart';

import '../models/UserModel.dart';

class AccountDetails extends StatefulWidget {
  final String? userId;

  const AccountDetails({this.userId});

  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  TextEditingController _nameController = TextEditingController();

  String? name;
  String? email;

  @override
  void initState() {
    super.initState();
    setInfo();
  }

  void setInfo() async {
    String? currentName = await getUsernameById(widget.userId);
    String? em = await getEmailById(widget.userId);

    setState(() {
      name = currentName;
      email = em;
    });
  }

  void updateName(String newName) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Update the name in Firestore
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(widget.userId)
            .update({'username': newName});

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Name updated successfully'),
        ));
        // Update the displayed name
        setState(() {
          name = newName;
        });
      } catch (error) {
        print('Error updating name: $error');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to update name. Please try again.'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fashion Co.'),
        backgroundColor: Colors.pink[400],
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Name:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Change Name'),
                          content: TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(labelText: 'New Name'),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Call function to update the name
                                updateName(_nameController.text);
                                Navigator.of(context).pop();
                              },
                              child: Text('Save'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            Text('$name', style: TextStyle(fontSize: 24, color: Colors.black),),
            SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: Text('Email:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
            Text('$email', style: TextStyle(fontSize: 24, color: Colors.black),),
            SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Password:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => updatePassword(userId: widget.userId)),
                            (route) => false);
                  },
                ),
              ],
            ),
            Text('*************', style: TextStyle(fontSize: 24, color: Colors.black),),
          ],
        ),
      ),
    );
  }
}

Future<String?> getUsernameById(String? userId) async {
  String? name;

  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('id', isEqualTo: userId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var userModel = UserModel.fromSnapshot(querySnapshot.docs.first as DocumentSnapshot<Map<String, dynamic>>);
      name = userModel.username;
    }
  } catch (error) {
    print('Error getting ID: $error');
  }

  return name;
}

Future<String?> getEmailById(String? userId) async {
  String? email;

  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('id', isEqualTo: userId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var userModel = UserModel.fromSnapshot(querySnapshot.docs.first as DocumentSnapshot<Map<String, dynamic>>);
      email = userModel.email;
    }
  } catch (error) {
    print('Error getting ID: $error');
  }

  return email;
}
