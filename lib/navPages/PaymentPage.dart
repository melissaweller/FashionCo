import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
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
        title: Text('Payment Information'),
        backgroundColor: Colors.pink[400],
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Credit Card Number:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _cardNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter card number',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Expiry Date:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _expiryDateController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'MM/YYYY',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'CVV:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _cvvController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter CVV',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.pink[400],
                  minimumSize: Size(300, 40)
              ),
              onPressed: () {
                // Process payment and proceed to CheckoutPage2
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => CheckoutPage2()),
                // );
              },
              child: Text('Proceed to Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
