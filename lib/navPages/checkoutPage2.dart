import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/navPages/AccountPage.dart';
import '../models/Navigation.dart';
import '../models/UserModel.dart';
import 'ProductPage.dart';

class checkoutPage2 extends StatefulWidget {
  final String? email;
  final List<dynamic> cart;

  checkoutPage2({required this.cart, required this.email});

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
    String? id = await getIdByEmail(widget.email);

    setState(() {
      userId = id;
    });
  }

  double _calculateTotalPrice() {
    double totalPrice = 0.0;
    for (dynamic product in widget.cart) {
      totalPrice += product['price'] ?? 0.0;
    }
    return totalPrice;
  }

  Future<void> _getOrderNumber() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('order_number')
          .doc('counter')
          .get();
      int latestOrderNumber = snapshot.data()?['latest_order_number'] ?? 0;
      setState(() {
        _orderNumber = latestOrderNumber + 1;
      });
    } catch (e) {
      print('Error fetching order number: $e');
    }
  }

  Future<void> _confirmOrder() async {
    try {
      String orderDocumentId = 'ORD$_orderNumber';

      DocumentSnapshot<Map<String, dynamic>> orderDocSnapshot =
          await FirebaseFirestore.instance
              .collection('orders')
              .doc(orderDocumentId)
              .get();

      if (!orderDocSnapshot.exists) {
        print('Order document does not exist');
        return;
      }

      await orderDocSnapshot.reference.update({
        'order_status': 'Confirmed',
      });

      await FirebaseFirestore.instance
          .collection('cart')
          .where('email', isEqualTo: widget.email)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      });

      await FirebaseFirestore.instance
          .collection('order_numbers')
          .doc('latest')
          .update({
        'order_number': _orderNumber!,
      });

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Navigation(
                    userId: userId,
                  )));
    } catch (e) {
      print('Error confirming order: $e');
    }
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
              height: 600,
              width: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Order Confirmation', style: TextStyle(fontSize: 30),),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.cart.length,
                      itemBuilder: (context, index) {
                        dynamic product = widget.cart[index];
                        return ListTile(
                          title: Text(product['title'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                          subtitle: Text('Price: \$${product['price']}', style: TextStyle(fontSize: 18),),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),

                  Text('Total Price: \$${_calculateTotalPrice().toStringAsFixed(2)}', style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.pink[400],
                      minimumSize: Size(300, 40),
                    ),
                    onPressed: () {
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

//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Confirm Order'),
//         backgroundColor: Colors.pink[400],
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: EdgeInsets.all(20),
//               height: 400,
//               width: 400,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Order Confirmation',
//                     style: TextStyle(fontSize: 30),
//                   ),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.black,
//                       backgroundColor: Colors.pink[400],
//                       minimumSize: Size(300, 40),
//                     ),
//                     onPressed: (){
//                       _confirmOrder();
//                     },
//                     child: Text('Confirm Order'),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

Future<String?> getIdByEmail(String? userEmail) async {
  String? id;

  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: userEmail)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var userModel = UserModel.fromSnapshot(
          querySnapshot.docs.first as DocumentSnapshot<Map<String, dynamic>>);
      id = userModel.id;
    }
  } catch (error) {
    print('Error getting ID: $error');
  }

  return id;
}
