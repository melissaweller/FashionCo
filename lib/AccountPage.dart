import 'dart:async';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountPage extends StatefulWidget {
  final String? username;
  const AccountPage({this.username});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
