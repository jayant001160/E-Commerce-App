import 'dart:convert';
import 'package:e_commerce_app/models/product.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartService extends ChangeNotifier {
  List<Product> _cart = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Product> get cart => _cart;

  Future<void> addToCart(Product product) async {
    _cart.add(product);
    notifyListeners();
    await _saveCartToFirestore();
  }

  Future<void> removeFromCart(Product product) async {
    _cart.remove(product);
    notifyListeners();
    await _saveCartToFirestore();
  }

  Future<void> clearCart() async {
    _cart.clear();
    notifyListeners();
    await _saveCartToFirestore();
  }

  Future<void> _saveCartToFirestore() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String uid = user.uid;
        await _firestore.collection('users').doc(uid).collection('cart').doc('userCart').set({
          'items': _cart.map((product) => product.toJson()).toList(),
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving cart to Firestore: $e');
      }
    }
  }

  Future<void> loadCartFromFirestore() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String uid = user.uid;
        DocumentSnapshot doc = await _firestore.collection('users').doc(uid).collection('cart').doc('userCart').get();
        if (doc.exists) {
          List<dynamic> items = doc['items'];
          _cart = items.map((item) => Product.fromJson(item)).toList();
          notifyListeners();
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading cart from Firestore: $e');
      }
    }
  }
}
