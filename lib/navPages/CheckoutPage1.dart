
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/navPages/PaymentPage.dart';

class CheckoutPage1 extends StatefulWidget {

  final String userEmail;
  final List<dynamic> cart;

  CheckoutPage1({required this.userEmail, required this.cart});

  @override
  State<CheckoutPage1> createState() => _CheckoutPage1State();
}

class _CheckoutPage1State extends State<CheckoutPage1> {

  final _nameController = TextEditingController();
  late var _emailController = TextEditingController(text: widget.userEmail);
  final _addressController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _cityController = TextEditingController();
  late var _countryController = TextEditingController(text: 'Canada');

  // Define list of provinces
  List<String> provinces = [
    'Quebec',
    'Ontario',
    'New Brunswick',
    'Alberta',
    'British Columbia',
    'Manitoba',
    'Newfoundland and Labrador',
    'Nova Scotia',
    'Prince Edward Island',
    'Saskatchewan',
  ];

  String? _selectedProvince; // Variable to hold selected province

  @override
  void initState() {
    super.initState();
  }

  Future<void> checkout(String userEmail, Map<String, dynamic> shippingInfo, List<dynamic> cart) async {

    DocumentSnapshot orderNumberSnapshot = await FirebaseFirestore.instance.collection('order_numbers').doc('latest').get();
    int latestOrderNumber = orderNumberSnapshot.exists ? orderNumberSnapshot['order_number'] : 0;

    int newOrderNumber = latestOrderNumber + 1;

    await FirebaseFirestore.instance.collection('order_numbers').doc('latest').set({'order_number': newOrderNumber});

    // Create a map to represent the order
    Map<String, dynamic> orderData = {
      'order_number': newOrderNumber.toString(),
      'order_status': 'Pending',
      'user_email': userEmail,
      'shipping_info': shippingInfo,
      'products': cart.map((product) => {
        'title': product['title'],
        'price': product['price'],
      }).toList(),
    };

    await FirebaseFirestore.instance.collection('orders').add(orderData);
  }

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
                    Text('Shipping Information', style: TextStyle(fontSize: 30),),
                    SizedBox(height: 10,),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        prefixIcon: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Icon(Icons.person_outline, color: Colors.pink[400],),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        prefixIcon: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Icon(Icons.email_outlined, color: Colors.pink[400],),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Address',
                        prefixIcon: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Icon(Icons.house_outlined, color: Colors.pink[400],),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller: _cityController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'City',
                        prefixIcon: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Icon(Icons.house_outlined, color: Colors.pink[400],),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller: _postalCodeController,
                      maxLength: 6,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Postal Code',
                        prefixIcon: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Icon(Icons.house_outlined, color: Colors.pink[400],),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    DropdownButtonFormField<String>(
                      value: _selectedProvince,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedProvince = newValue;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Province',
                        prefixIcon: Icon(Icons.location_city_outlined, color: Colors.pink[400]),
                      ),
                      items: provinces.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller: _countryController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Country',
                        prefixIcon: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Icon(Icons.house_outlined, color: Colors.pink[400],),
                        ),
                      ),
                    ),
                    SizedBox(height: 40,),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.pink[400],
                            minimumSize: Size(300, 40)
                        ),
                        onPressed: () async {
                          Map<String, dynamic> shippingInfo = {
                            'name': _nameController.text,
                            'email': _emailController.text,
                            'address': _addressController.text,
                            'city': _cityController.text,
                            'postal_code': _postalCodeController.text,
                            'province': _selectedProvince,
                            'country': _countryController.text,
                          };
                          await checkout(widget.userEmail, shippingInfo, widget.cart);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentPage(cart: widget.cart),
                            ),
                          );
                        },
                        child: Text('Continue to Payment Information')
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}