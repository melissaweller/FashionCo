import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/UserModel.dart';
import 'CartPage.dart';
import 'ItemPage.dart';
import 'ProductCard.dart';

class ProductPage extends StatefulWidget {

  final String? userId;

  const ProductPage({Key? key, this.userId});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  late String email;

  void setInfo() async {
    String? em = await getEmailById(widget.userId);
    setState(() {
      email = em!;
    });
  }

  List<dynamic> searchResults = [];
  List<dynamic> allProducts = [];
  List<dynamic> cart = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchSearchResults();
    setInfo();
  }

  Future<void> fetchSearchResults() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      setState(() {
        searchResults = json.decode(response.body);
        allProducts = List.from(searchResults);
      });
    } else {
      throw Exception('Failed to load search results');
    }
  }

  void search(String query) {
    List<dynamic> results = [];
    if (query.isEmpty) {
      results = List.from(allProducts);
    }
    else {
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

  void addToCart(dynamic product) {
    int existingIndex = cart.indexWhere((item) => item['id'] == product['id']);

    if (existingIndex != -1) {
      setState(() {
        cart[existingIndex]['quantity'] += 1;
      });

      FirebaseFirestore.instance.collection('cart').doc(cart[existingIndex]['docId']).update({
        'quantity': cart[existingIndex]['quantity'],
      });
    } else {
      FirebaseFirestore.instance.collection('cart').add({
        'product_id': product['id'],
        'title': product['title'],
        'price': product['price'],
        'quantity': 1, // Initial quantity is 1
        'image': product['image'],
        'email': email
      }).then((docRef) {
        setState(() {
          cart.add({
            ...product,
            'quantity': 1,
            'docId': docRef.id, // Assign the docId here
          });
        });
      });
    }
  }


  void navigateToCartPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(userEmail: email,),),);
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
      body: ListView(
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
          Flexible(
            child: GridView.count(
              crossAxisCount: 2, // Display 2 products per row
              childAspectRatio: 0.9, // Adjust this value to make the grid items bigger
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: searchResults.map((product) {
                return ProductCard(
                  product: product,
                  onTap: () => navigateToItemPage(context, product),
                  addToCart: () => addToCart(product),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
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