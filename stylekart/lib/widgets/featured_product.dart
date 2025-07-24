
import 'package:flutter/material.dart';
import '../model/productmodel.dart';
import '../product/productitem.dart';
import '../product/product.dart';
Widget buildFeaturedProductsSection() {
    // Take a subset of products for featured, e.g., first 6 from allProducts
    final List<Product> featuredProducts = allProducts.take(6).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        shrinkWrap: true, // Important for nested scroll views
        physics: const NeverScrollableScrollPhysics(), // Disable scrolling for this grid
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.7, // Adjust as needed for product item height
        ),
        itemCount: featuredProducts.length,
        itemBuilder: (context, index) {
          return ProductItem(product: featuredProducts[index]);
        },
      ),
    );
  }