import 'package:flutter/material.dart';

class OrderDetailsPage extends StatelessWidget {
  final Map<String, dynamic> orderData;

  const OrderDetailsPage({required this.orderData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fashion Co.'),
        backgroundColor: Colors.pink[400],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order Number:', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
            SizedBox(height: 5),
            Text('${orderData['order_number']}', style: TextStyle(fontSize: 16),),
            SizedBox(height: 20),
            Text('Products:', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (orderData['products'] as List<dynamic>).map<Widget>((product) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${product['title']}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        '\$${product['price']}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
