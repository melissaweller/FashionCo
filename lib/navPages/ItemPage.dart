import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemPage extends StatelessWidget {
  final dynamic product;

  const ItemPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fashion Co.'),
        backgroundColor: Colors.pink[400],
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(product['image'], height: 150, ),
              SizedBox(height: 20),
              Text(product['title'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Text('\$${product['price'].toString()}', style: TextStyle(fontSize: 24, color: Colors.green)),
              SizedBox(height: 20),
              Text(product['description'], style: TextStyle(fontSize: 16)),
            ],
          ),
        )
      ),
    );
  }
}
