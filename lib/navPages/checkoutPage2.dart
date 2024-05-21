import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/UserModel.dart';
import 'ProductPage.dart';

class checkoutPage2 extends StatefulWidget {
  final String? userEmail;
  final List<dynamic> cart;

  checkoutPage2({required this.cart, this.userEmail});

  @override
  _checkoutPage2State createState() => _checkoutPage2State();
}

class _checkoutPage2State extends State<checkoutPage2> {

  int? _orderNumber;
  String? userId;

  @override
  void initState() {
    super.initState();
    _getOrderNumber();
    setInfo();
  }

  void setInfo() async {
    String? id = await getID(widget.userEmail);

    setState(() {
      userId = id;
    });
  }

  Future<void> _getOrderNumber() async {
    // Fetch the latest order number from Firestore
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('order_number').doc('counter').get();
      int latestOrderNumber = snapshot.data()?['latest_order_number'] ?? 0;
      setState(() {
        _orderNumber = latestOrderNumber + 1;
      });
    } catch (e) {
      print('Error fetching order number: $e');
    }
  }

  Future<void> _confirmOrder() async {
    // Clear the cart
    widget.cart.clear();

    // Update the order status and order number in Firestore
    try {
      await FirebaseFirestore.instance.collection('orders').doc('$_orderNumber').update({
        'order_status': 'Confirmed',
      });

      // Increment the order number in Firestore
      await FirebaseFirestore.instance.collection('order_number').doc('counter').update({
        'latest_order_number': _orderNumber!,
      });
    } catch (e) {
      print('Error confirming order: $e');
    }

    // Navigate back to the home page or another page
    Navigator.push(context,MaterialPageRoute(builder: (context) => ProductPage(userId: userId,)),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Order'),
        backgroundColor: Colors.pink[400],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Order Confirmation',
                    style: TextStyle(fontSize: 30),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.pink[400],
                      minimumSize: Size(300, 40),
                    ),
                    onPressed: (){
                      _confirmOrder();
                    },
                    child: Text('Confirm Order'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String?> getID(String? userEmail) async {
  String? id;

  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('id', isEqualTo: userEmail)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var userModel = UserModel.fromSnapshot(querySnapshot.docs.first as DocumentSnapshot<Map<String, dynamic>>);
      id = userModel.id;
    }
  } catch (error) {
    print('Error getting ID: $error');
  }

  return id;
}