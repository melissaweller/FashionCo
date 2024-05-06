import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:profile_photo/profile_photo.dart';

import '../models/UserModel.dart';
import 'AccountDetails.dart';
import 'MyOrders.dart';

class AccountPage extends StatefulWidget {

  final String? userId;

  const AccountPage({this.userId});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  String? username;
  String? email;

  @override
  void initState()  {
    super.initState();
    setInfo();
  }

  void setInfo() async {
    String? name = await getUsernameById(widget.userId);
    String? em = await getEmailById(widget.userId);
    setState(() {
      username = name;
      email = em;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      ProfilePhoto(
                        totalWidth: 100,
                        cornerRadius: 25,
                        color: Colors.black,
                        image:  AssetImage('assets/profile_picture.png'),
                        outlineWidth: 2,
                      ),
                      SizedBox(height: 20,),
                      Text(" ${username}", style: TextStyle(fontSize: 20),),
                      Text(" ${email}", style: TextStyle(fontSize: 20),),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Expanded(child: ListView(
                  children: [
                    _SingleSection(
                      title: "",
                      children: [
                        _CustomListTile(title: "My Orders", leading: Icons.language, trailing: Icons.arrow_forward,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrders(),),
                            );
                          },
                        ),
                        Divider(color: Colors.black,),
                        _CustomListTile(title: "Account Details", leading: Icons.cloud_outlined, trailing: Icons.arrow_forward,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AccountDetails(),),
                            );
                          },
                        ),
                        Divider(color: Colors.black,),
                        _CustomListTile(title: "Log Out", leading: Icons.cloud_outlined, trailing: Icons.arrow_forward,
                          onTap: () {
                            // implement log out
                          },
                        ),
                        Divider(color: Colors.black,),
                      ],
                    ),
                  ],
                ),)
              ],
            )
        )
    );
  }
}

Future<String?> getUsernameById(String? id) async {
  String? username;

  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('id', isEqualTo: id)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var userModel = UserModel.fromSnapshot(querySnapshot.docs.first as DocumentSnapshot<Map<String, dynamic>>);
      username = userModel.username;
    }
  } catch (error) {
    print('Error getting ID: $error');
  }

  return username;
}

Future<String?> getEmailById(String? id) async {
  String? email;

  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('id', isEqualTo: id)
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

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData leading;
  final IconData trailing;
  final VoidCallback onTap; // Callback for handling the click event

  const _CustomListTile(
      {Key? key,
        required this.title,
        required this.leading,
        required this.trailing,
        required this.onTap}) // Pass the onTap callback from the parent widget
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // Wrap the ListTile with GestureDetector
      onTap: onTap, // Assign the onTap callback
      child: ListTile(
        title: Text(title),
        leading: Icon(leading),
        trailing: Icon(trailing),
      ),
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;

  const _SingleSection({
    Key? key,
    this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        Column(
          children: children,
        ),
      ],
    );
  }
}