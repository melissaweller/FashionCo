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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(product['image'], height: 250, ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.yellow,),
                  Text('${product['rating']['rate']}  (${product['rating']['count']})', style: TextStyle(fontSize: 16),),
                ],
              ),
              SizedBox(height: 20,),
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
