import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final List<dynamic> cart;

  const CartPage({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalCost = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.pink[400],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final product = cart[index];
                double price = product['price'] ?? 0; // Handle null price
                int quantity = product['quantity'] ?? 0; // Handle null quantity
                totalCost += price * quantity;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      leading: SizedBox(
                        height: 150,
                        child: Image.network(
                          product['image'] ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        product['title'] ?? '',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Price: \$${price.toStringAsFixed(2)}'),
                          Text('Quantity: $quantity'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Remove item from cart
                          // You can implement the removal logic here
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total: \$${totalCost.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
