import 'dart:async';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProductService extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Product> _products = [];
  final StreamController<List<Product>> _productController = StreamController.broadcast();

  ProductService() {
    fetchProducts();
  }

  Stream<List<Product>> get productStream => _productController.stream;

  Future<void> fetchProducts() async {
    try {
      _products = await _apiService.fetchProducts();
      _productController.add(_products);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void searchProducts(String query) {
    List<Product> filteredProducts = _products
        .where((product) => product.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    _productController.add(filteredProducts);
  }

  @override
  void dispose() {
    _productController.close();
    super.dispose();
  }
}
