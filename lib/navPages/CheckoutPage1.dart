import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/UserModel.dart';

class CheckoutPage1 extends StatefulWidget {

  final String userEmail;

  CheckoutPage1({required this.userEmail});

  @override
  State<CheckoutPage1> createState() => _CheckoutPage1State();
}

class _CheckoutPage1State extends State<CheckoutPage1> {

  final _nameController = TextEditingController();
  late var _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _provinceController = TextEditingController();

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
    _emailController = TextEditingController(text: widget.userEmail);
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
                        onPressed: (){

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