import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/navPages/CheckoutPage1.dart';

import '../models/UserModel.dart';

class CartPage extends StatelessWidget {
  final String userEmail;

  CartPage({required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fashion Co.'),
        backgroundColor: Colors.pink[400],
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('cart').where('email', isEqualTo: userEmail).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Display loading indicator while waiting for data
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Your cart is empty')); // Display message if cart is empty
          }
          List<dynamic> cartItems = snapshot.data!.docs.map((doc) => doc.data()).toList();

          // Calculate total price
          double subtotal = 0;
          for (var item in cartItems) {
            subtotal += (item['price'] * item['quantity']);
          }

          // Calculate taxes
          double gst = subtotal * 0.0499; // GST (4.99%)
          double qst = subtotal * 0.0975; // QST (9.975%)

          // Calculate total price including taxes
          double totalPrice = subtotal + gst + qst;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final product = cartItems[index];
                    return ListTile(
                      leading: SizedBox(
                        height: 50,
                        width: 50,
                        child: Image.network(
                          product['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(product['title']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Price: \$${product['price']}'),
                          Text('Quantity: ${product['quantity']}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          FirebaseFirestore.instance.collection('cart').doc(snapshot.data!.docs[index].id).delete();
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    Text('Subtotal: \$${subtotal.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),),
                    Text('GST (4.99%): \$${gst.toStringAsFixed(2)}', style: TextStyle(fontSize: 16, color: Colors.black), ),
                    Text('QST (9.97%): \$${qst.toStringAsFixed(2)}', style: TextStyle(fontSize: 16, color: Colors.black), ),
                    Divider(color: Colors.black,),
                    Text('Total Price: \$${totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
                  ],
                )
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.pink[400],
                    minimumSize: Size(80, 40)
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutPage1(userEmail: userEmail,),),);
                },
                child: Text('Checkout', style: TextStyle(fontSize: 16, color: Colors.white),),
              ),
              SizedBox(height: 20,),
            ],
          );
        },
      ),
    );
  }
}







