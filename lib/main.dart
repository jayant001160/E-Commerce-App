import 'package:e_commerce_app/firebase_options.dart';
import 'package:e_commerce_app/screens/home_screen.dart';
import 'package:e_commerce_app/screens/login_screen.dart';
import 'package:e_commerce_app/screens/registration_screen.dart';
import 'package:e_commerce_app/screens/product_detail_screen.dart';
import 'package:e_commerce_app/screens/cart_screen.dart';
import 'package:e_commerce_app/services/cart_service.dart';
import 'package:e_commerce_app/services/product_service.dart';
import 'package:e_commerce_app/services/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartService()..loadCartFromFirestore()),
        ChangeNotifierProvider(create: (context) => ProductService()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'E-Commerce App',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          initialRoute: '/login',
          routes: {
            '/login': (context) => LoginScreen(),
            '/register': (context) => RegistrationScreen(),
            '/home': (context) => HomeScreen(),
            '/product': (context) => ProductDetailScreen(),
            '/cart': (context) => CartScreen(),
          },
        );
      },
    );
  }
}
