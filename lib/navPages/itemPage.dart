import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/models/FirebaseAuthService.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ItemPage extends StatelessWidget {
  final dynamic product;

  const ItemPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['title']),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(product['image'], height: 150),
            SizedBox(height: 20),
            Text(product['title'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('\$${product['price'].toString()}',
                style: TextStyle(fontSize: 16, color: Colors.green)),
            SizedBox(height: 10),
            Text('Category: ${product['category']}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text(product['description'], style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}