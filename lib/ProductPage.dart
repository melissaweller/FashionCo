import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'AccountPage.dart';
import 'CartPage.dart';
import 'HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/models/FirebaseAuthService.dart';

class ProductPage extends StatefulWidget {
  final String? username;

  const ProductPage({this.username});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(" ${widget.username}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
      )
    );
  }
}
