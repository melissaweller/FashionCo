import 'dart:async';
import 'package:flutter/material.dart';
import 'AccountPage.dart';
import 'CartPage.dart';
import 'ProductPage.dart';
import 'SearchPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _selectedIndex = 0;

  List<Widget> _widgetOptions = [
    ProductPage(),
    SearchPage(),
    CartPage(),
    AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fashion Co.'),
        backgroundColor: Colors.pink[400],
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
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

