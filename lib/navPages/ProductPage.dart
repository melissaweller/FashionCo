import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/models/FirebaseAuthService.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'itemPage.dart';

class ProductPage extends StatefulWidget {
  final String? username;

  const ProductPage({this.username});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response =
    await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      setState(() {
        products = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  void navigateToItemPage(BuildContext context, dynamic product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemPage(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () => navigateToItemPage(context, product),
                  child: Card(
                    margin: EdgeInsets.all(0),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(product['image'], height: 120),
                          SizedBox(height: 10),
                          Text(product['title'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Text('\$${product['price'].toString()}', style: TextStyle(fontSize: 14, color: Colors.green)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      )
    );
  }
}

