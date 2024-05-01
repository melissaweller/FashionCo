import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'CartPage.dart';
import 'ItemPage.dart';
import 'ProductCard.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<dynamic> searchResults = [];
  List<dynamic> allProducts = []; // Store all products
  List<dynamic> cart = []; // Initialize cart
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchSearchResults();
  }

  Future<void> fetchSearchResults() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      setState(() {
        searchResults = json.decode(response.body);
        allProducts = List.from(searchResults); // Store all products
      });
    } else {
      throw Exception('Failed to load search results');
    }
  }

  void search(String query) {
    List<dynamic> results = [];
    if (query.isEmpty) {
      results = List.from(allProducts); // Show all products if search query is empty
    } else {
      results = allProducts
          .where((product) =>
      product['title'].toLowerCase().contains(query.toLowerCase()) ||
          product['category'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() {
      searchResults = results;
    });
  }

  void navigateToItemPage(BuildContext context, dynamic product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemPage(product: product),
      ),
    );
  }

  // void addToCart(dynamic product) {
  //   int existingIndex = cart.indexWhere((item) => item['id'] == product['id']);
  //
  //   if (existingIndex != -1) {
  //     setState(() {
  //       cart[existingIndex]['quantity'] += 1;
  //     });
  //   } else {
  //     setState(() {
  //       cart.add({...product, 'quantity': 1});
  //     });
  //
  //     // Add product to Firestore cart collection
  //     FirebaseFirestore.instance.collection('cart').add({
  //       'id': product['id'],
  //       'title': product['title'],
  //       'price': product['price'],
  //       'quantity': 1, // Initial quantity is 1
  //       'image': product['image'],
  //     });
  //   }
  // }

  void addToCart(dynamic product) {
    int existingIndex = cart.indexWhere((item) => item['id'] == product['id']);

    if (existingIndex != -1) {
      setState(() {
        cart[existingIndex]['quantity'] += 1;
      });
      // Update quantity in Firestore
      FirebaseFirestore.instance.collection('cart').doc(cart[existingIndex]['docId']).update({
        'quantity': cart[existingIndex]['quantity'],
      });
    } else {
      setState(() {
        cart.add({...product, 'quantity': 1});
      });
      // Add product to Firestore cart collection
      FirebaseFirestore.instance.collection('cart').add({
        'id': product['id'],
        'title': product['title'],
        'price': product['price'],
        'quantity': 1, // Initial quantity is 1
        'image': product['image'],
      }).then((docRef) {
        // Store the document ID for future updates
        cart[cart.length - 1]['docId'] = docRef.id;
      });
    }
  }

  void navigateToCartPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fashion Co.'),
        backgroundColor: Colors.pink[400],
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => navigateToCartPage(context),
            icon: Icon(Icons.shopping_cart, color: Colors.white,),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => search(value),
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: searchResults.map((product) {
                  return ProductCard(
                    product: product,
                    onTap: () => navigateToItemPage(context, product),
                    addToCart: () => addToCart(product), // Pass the addToCart function to ProductCard
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}