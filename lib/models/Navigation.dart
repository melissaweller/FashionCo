import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../navPages/AccountPage.dart';
import '../navPages/ProductPage.dart';
import 'UserModel.dart';

class Navigation extends StatefulWidget {
  final String? userId;

  Navigation({required this.userId});

  @override
  State<Navigation> createState() => _NavigatingScreenState();
}

class _NavigatingScreenState extends State<Navigation> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[
        ProductPage(userId: widget.userId),
        AccountPage(userId: widget.userId)
      ][_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home Page', backgroundColor: Colors.pink[400]),
          BottomNavigationBarItem(icon: Icon(Icons.account_box), label: 'Account', backgroundColor:  Colors.pink[400]),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        iconSize: 40,
        onTap: _onItemTapped,
        elevation: 5,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
