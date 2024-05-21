
import 'package:flutter/material.dart';
import 'package:project/navPages/checkoutPage2.dart';

class PaymentPage extends StatefulWidget {
  final List<dynamic> cart;

  PaymentPage({required this.cart});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fashion Co.'),
        backgroundColor: Colors.pink[400],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              height: 800,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text('Payment Information', style: TextStyle(fontSize: 30),),
                  SizedBox(height: 10,),
                  TextField(
                    controller: _cardNumberController,
                    maxLength: 16,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Credit Card Number',
                      prefixIcon: Icon(Icons.credit_card, color: Colors.pink[400]),
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    controller: _expiryDateController,
                    maxLength: 6,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Expiry Date (MM/YYYY)',
                      prefixIcon: Icon(Icons.calendar_today, color: Colors.pink[400]),
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    controller: _cvvController,
                    maxLength: 3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'CVV',
                      prefixIcon: Icon(Icons.security, color: Colors.pink[400]),
                    ),
                  ),
                  SizedBox(height: 40,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.pink[400],
                      minimumSize: Size(300, 40),
                    ),
                    onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) => checkoutPage2(cart: widget.cart)),);
                    },
                    child: Text('Proceed to Confirmation'),
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
