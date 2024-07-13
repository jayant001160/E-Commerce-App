import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/services/cart_service.dart';
import 'package:another_flushbar/flushbar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              _showClearCartConfirmation(context, cartService);
            },
          ),
        ],
      ),
      body: cartService.cart.isEmpty
          ? const Center(
        child: Text('Your cart is empty'),
      )
          : ListView.builder(
        itemCount: cartService.cart.length,
        itemBuilder: (context, index) {
          final Product product = cartService.cart[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: ListTile(
              leading: Image.network(
                product.image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(product.title),
              subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
              trailing: IconButton(
                icon: const Icon(Icons.remove_circle),
                onPressed: () {
                  _showRemoveItemConfirmation(context, cartService, product);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showCheckoutMessage(context);
        },
        icon: const Icon(Icons.shopping_cart),
        label: const Text('Checkout'),
      ),
    );
  }

  void _showRemoveItemConfirmation(BuildContext context, CartService cartService, Product product) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.delete),
                title: Text('Remove ${product.title} from cart?'),
                onTap: () {
                  Navigator.pop(context);
                  _removeItemAndNotify(context, cartService, product);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _removeItemAndNotify(BuildContext context, CartService cartService, Product product) {
    cartService.removeFromCart(product);
    Flushbar(
      message: '${product.title} removed from cart',
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  void _showClearCartConfirmation(BuildContext context, CartService cartService) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.delete_forever),
                title: const Text('Clear all items from cart?'),
                onTap: () {
                  Navigator.pop(context);
                  _clearCartAndNotify(context, cartService);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _clearCartAndNotify(BuildContext context, CartService cartService) {
    cartService.clearCart();
    Flushbar(
      message: 'Cart cleared',
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  void _showCheckoutMessage(BuildContext context) {
    Flushbar(
      message: 'Error: 404 You haven\'t paid your developer yet',
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.red,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8.0),
    ).show(context);
  }
}
