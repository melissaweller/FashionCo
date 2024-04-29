import 'dart:async';
import 'package:flutter/material.dart';
import '../HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:profile_photo/profile_photo.dart';

class AccountPage extends StatefulWidget {

  final String? username;
  final String? email;
  const AccountPage({this.username, this.email});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
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
                  Text(" ${widget.username}", style: TextStyle(fontSize: 20),),
                ],
              ),
            ),
            SizedBox(height: 10,),
            ListView(
              children: [
                _SingleSection(
                  title: "Common",
                  children: [
                    _CustomListTile(title: "My Orders", leading: Icons.language, trailing: Icons.arrow_forward,),
                    Divider(color: Colors.black,),
                    _CustomListTile(title: "Account Details", leading: Icons.cloud_outlined, trailing: Icons.arrow_forward,),
                    Divider(color: Colors.black,),
                    _CustomListTile(title: "Log Out", leading: Icons.cloud_outlined, trailing: Icons.arrow_forward,),
                  ],
                ),
              ],
            ),
          ],
        )
      )
    );
  }
}


class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData leading;
  final IconData trailing;

  const _CustomListTile(
      {Key? key, required this.title, required this.leading, required this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(leading),
      trailing: Icon(trailing),
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