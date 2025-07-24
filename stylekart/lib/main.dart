import 'package:flutter/material.dart';
import 'product/product.dart';
import 'model/productmodel.dart';
import 'home.dart';
import 'Screens/category_screen.dart';
import 'Screens/screen.dart';


void main() {
  runApp(const MyApp());
}

// Helper function to get products by category
List<Product> getProductsByCategory(String category) {
  return allProducts
      .where((product) => product.category == category)
      .toList();
}

// --- Main Application Widget ---
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StyleKart',
      debugShowCheckedModeBanner: false, // Remove debug banner
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: 'Inter', // A modern font for Gen Z appeal
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        // Enhance button style for a modern look
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple, // A vibrant color
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ),
      home: const HomeScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/men': (context) =>
            CategoryScreen(categoryName: 'Men', products: getProductsByCategory('Men')),
        '/women': (context) =>
            CategoryScreen(categoryName: 'Women', products: getProductsByCategory('Women')),
        '/kids': (context) =>
            CategoryScreen(categoryName: 'Kids', products: getProductsByCategory('Kids')),
        '/shoes': (context) =>
            CategoryScreen(categoryName: 'Shoes', products: getProductsByCategory('Shoes')),
        '/accessories': (context) => CategoryScreen(
            categoryName: 'Accessories', products: getProductsByCategory('Accessories')),
        '/winter_collection': (context) => CategoryScreen(
            categoryName: 'Winter Collection',
            products: getProductsByCategory('Winter Collection')),
        '/cart': (context) => const SimpleScreen(title: 'Shopping Cart', icon: Icons.shopping_cart),
        '/profile': (context) => const SimpleScreen(title: 'User Profile', icon: Icons.person),
        '/logout': (context) => const SimpleScreen(title: 'Logged Out', icon: Icons.logout),
      },
    );
  }
}


