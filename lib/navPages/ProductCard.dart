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
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(product['title'], style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    Text('\$${product['price'].toString()}', style: TextStyle(fontSize: 12, color: Colors.green)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.pink[400],
                          minimumSize: Size(10, 20)
                      ),
                      onPressed: (){
                        addToCart();
                      }, // Call addToCart function when button is pressed
                      child: Text('Add to Cart', style: TextStyle(fontSize: 10, color: Colors.white),),
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