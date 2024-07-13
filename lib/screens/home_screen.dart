import 'package:flutter/material.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/services/product_service.dart';
import 'package:e_commerce_app/services/theme_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);


    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          Switch(
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),

        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(screenSize.height * 0.08),
          child: Padding(
            padding: EdgeInsets.all(screenSize.width * 0.02),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Products',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenSize.width * 0.04),
                ),
                suffixIcon: const Icon(Icons.search),
              ),
              onChanged: (query) {
                productService.searchProducts(query);
              },
            ),
          ),
        ),
      ),
      body: StreamBuilder<List<Product>>(
        stream: productService.productStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products available'));
          }

          final List<Product> products = snapshot.data!;


          List<Product> filteredProducts = _searchController.text.isNotEmpty
              ? products.where((product) => product.title.toLowerCase().contains(_searchController.text.toLowerCase())).toList()
              : products;


          Map<String, List<Product>> categorizedProducts = {};
          filteredProducts.forEach((product) {
            if (!categorizedProducts.containsKey(product.category)) {
              categorizedProducts[product.category] = [];
            }
            categorizedProducts[product.category]!.add(product);
          });

          return ListView.builder(
            itemCount: categorizedProducts.length,
            itemBuilder: (context, index) {
              String category = categorizedProducts.keys.elementAt(index);
              List<Product> categoryProducts = categorizedProducts[category]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(screenSize.width * 0.02),
                    child: Text(
                      _capitalize(category),
                      style: TextStyle(fontSize: screenSize.width * 0.06, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.3,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: categoryProducts.map((product) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/product', arguments: product);
                            },
                            child: Container(
                              width: screenSize.width * 0.4, // Responsive width
                              margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02),
                              child: Card(
                                elevation: 4.0,
                                shadowColor: Colors.grey.withOpacity(0.5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: Image.network(
                                        product.image,
                                        width: screenSize.width * 0.4,
                                        height: screenSize.height * 0.2,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(screenSize.width * 0.03),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.title,
                                            maxLines: 2, // Limit title to 2 lines
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: screenSize.width * 0.04,
                                            ),
                                          ),
                                          SizedBox(height: screenSize.height * 0.01),
                                          Text(
                                            '\$${product.price}',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: screenSize.width * 0.035,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }


  String _capitalize(String input) {
    List<String> words = input.split(' ');
    words = words.map((word) => word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1)}' : '').toList();
    return words.join(' ');
  }
}
