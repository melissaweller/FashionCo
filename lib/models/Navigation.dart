import 'package:flutter/material.dart';

import '../AccountPage.dart';
import '../CartPage.dart';
import '../ProductPage.dart';
import '../SearchPage.dart';


class Navigation extends StatefulWidget {
  final String? username;

  Navigation({super.key, required this.username});

  @override
  State<Navigation> createState() => _NavigatingScreenState();
}

class _NavigatingScreenState extends State<Navigation> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fashion Co.'),
        backgroundColor: Colors.pink[400],
        centerTitle: true,
      ),
      body: <Widget>[
        ProductPage(username: widget.username),
        SearchPage(username: widget.username),
        CartPage(username: widget.username),
        AccountPage(username: widget.username)
      ][_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home Page', backgroundColor: Colors.pink[400]),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search', backgroundColor:  Colors.pink[400]),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Settings', backgroundColor:  Colors.pink[400]),
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