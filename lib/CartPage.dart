import 'dart:async';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartPage extends StatefulWidget {
  final String? username;

  const CartPage({this.username});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
