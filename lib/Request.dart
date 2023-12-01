import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class Product {
  final String name;
  final String description;
  final String imagePath;

  Product({required this.name, required this.description, required this.imagePath});
}

class RequestPage extends StatelessWidget {
  final List<Product> products = [
    Product(name: 'Name:', description: 'Breed: \n Age:\n Dates:', imagePath: 'assets/images/avtar.png'),
    Product(name: 'Name:', description: 'Breed: \n Age:\n Dates:', imagePath: 'assets/images/avtar.png'),
    Product(name: 'Name:', description: 'Breed: \n Age:\n Dates:', imagePath: 'assets/images/avtar.png'),
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: Image.asset(
          product.imagePath,
          fit: BoxFit.cover,
        ),
        title: Text(
          product.name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          product.description,
          style: TextStyle(fontSize: 16),
        ),
        trailing: ElevatedButton(
          onPressed: () {
            // Action to perform when the button is pressed
            // For example, navigate to the profile page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage1(product: product)),
            );
          },
          child: Text('See Profile'),
        ),
      ),
    );
  }
}

class ProfilePage1 extends StatelessWidget {
  final Product product;

  const ProfilePage1({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              product.imagePath,
              width: 500,
              height: 100,
              // fit: BoxFit.cover,
            ),
            Text('Product Name: ${product.name}'),
            SizedBox(height: 8),
            Text('Product Description: ${product.description}'),
            SizedBox(height: 8),

            Column(
              // ...
              children: [
                // ...

                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20.0,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    // Perform an action with the selected rating
                  },
                ),

                // ...
              ],
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Action to perform when the "Approve" button is pressed
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: Text(
                    'Approve',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Action to perform when the "Deny" button is pressed
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,

                  ),
                  child: Text(
                    'Deny',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "feedback");
                    // Action to perform when the "Deny" button is pressed
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,

                  ),
                  child: Text(
                    'Thank you',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
