import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/services/cart_service.dart';
import 'package:another_flushbar/flushbar.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context)!.settings.arguments as Product;
    final cartService = Provider.of<CartService>(context, listen: false);
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: screenSize.height * 0.3,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    product.image,
                    fit: BoxFit.contain,
                    width: screenSize.width * 0.8,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenSize.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: screenSize.height * 0.02),
                  Text(
                    product.title,
                    style: TextStyle(fontSize: screenSize.width * 0.06, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: screenSize.height * 0.01),
                  Text(
                    '\$${product.price}',
                    style: TextStyle(fontSize: screenSize.width * 0.05),
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  Text(
                    product.description,
                    style: TextStyle(fontSize: screenSize.width * 0.04),
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.02, horizontal: screenSize.width * 0.1),
                      elevation: 4.0,
                      shadowColor: Colors.grey.withOpacity(0.5),
                    ),
                    onPressed: () {
                      cartService.addToCart(product);
                      Flushbar(
                        title: 'Added to Cart',
                        message: 'You have added ${product.title} to your cart',
                        duration: const Duration(seconds: 3),
                        flushbarPosition: FlushbarPosition.BOTTOM,
                        flushbarStyle: FlushbarStyle.FLOATING,
                        borderRadius: BorderRadius.circular(10.0),
                        margin: const EdgeInsets.all(8.0),
                        icon: const Icon(Icons.check, color: Colors.white),
                        backgroundColor: Colors.green,
                        onTap: (flushbar) {
                          Navigator.pushNamed(context, '/cart');
                        },
                      ).show(context);
                    },
                    child: Text('Add to Cart', style: TextStyle(fontSize: screenSize.width * 0.04)),
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
