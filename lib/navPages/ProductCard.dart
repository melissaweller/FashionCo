
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCard extends StatefulWidget {
  final userID;
  final dynamic product;
  final VoidCallback onTap;
  final VoidCallback addToCart;
  final bool isFavorite; // Add a boolean flag to determine if the product is a favorite

  const ProductCard({
    this.userID,
    required this.product,
    required this.onTap,
    required this.addToCart,
    this.isFavorite = false, // Add isFavorite parameter
  });

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  Future<void> toggleFavoriteStatus() async {
    setState(() {
      isFavorite = !isFavorite;
    });

    final favoritesCollection = FirebaseFirestore.instance.collection('favorites');

    if (isFavorite) {
      await favoritesCollection.add({
        'productId': widget.product['id'],
        'userId': widget.userID,
        'timestamp': Timestamp.now(),
      });
    } else {
      final querySnapshot = await favoritesCollection
          .where('productId', isEqualTo: widget.product['id'])
          .where('userId', isEqualTo: widget.userID)
          .get();

      for (final doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: widget.onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                widget.product['image'],
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.product['title'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                    onPressed: toggleFavoriteStatus,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '\$${widget.product['price']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                onPressed: widget.addToCart,
                child: Text('Add to Cart'),
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}


