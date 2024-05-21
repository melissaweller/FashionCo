import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/UserModel.dart';

class MyOrders extends StatefulWidget {
  final String? userId;

  const MyOrders({required this.userId});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {

  late String email;

  void setInfo() async {
    String? em = await getEmailById(widget.userId);
    setState(() {
      email = em!;
    });
  }

  @override
  void initState() {
    super.initState();
    setInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fashion Co.'),
        backgroundColor: Colors.pink[400],
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('user_email', isEqualTo: email)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No orders found.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot orderDoc = snapshot.data!.docs[index];
              Map<String, dynamic> orderData = orderDoc.data() as Map<String, dynamic>;

              List<dynamic> products = orderData['products'];

              return GestureDetector(
                onTap: () {
                  _showOrderDetails(context, orderData);
                },
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Icon(Icons.account_circle_rounded),
                    title: Text('Order Number: ${orderDoc.id}'),
                  ),
                ),
              );
            },
          );
        },
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

  void _showOrderDetails(BuildContext context, Map<String, dynamic> orderData) {
    List<dynamic> products = orderData['products'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Products:'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: products.map((product) {
                  return Text('${product['title']} - \$${product['price']}');
                }).toList(),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

