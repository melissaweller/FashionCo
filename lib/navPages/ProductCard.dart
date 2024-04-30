import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final dynamic product;
  final VoidCallback onTap;
  final VoidCallback addToCart; // Callback to add product to cart

  const ProductCard({Key? key, required this.product, required this.onTap, required this.addToCart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Image.network(product['image'], height: 100),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product['title'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text('\$${product['price'].toString()}', style: TextStyle(fontSize: 14, color: Colors.green)),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: (){
                        addToCart();
                      }, // Call addToCart function when button is pressed
                      child: Text('Add to Cart'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}