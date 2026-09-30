import codecs

content = """import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';

class CategoryProductsScreen extends StatelessWidget { 
  final String categoryName; 
  final Map<String, dynamic>? filter; 
  
  const CategoryProductsScreen({super.key, required this.categoryName, this.filter}); 

  @override 
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), 
        backgroundColor: Colors.white, 
        elevation: 0, 
        iconTheme: const IconThemeData(color: Colors.black)
      ), 
      body: ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: globalProducts,
        builder: (context, products, child) {
          List<Map<String, dynamic>> filtered = List.from(products);
          
          if (filter != null) {
            if (filter!['price'] != null) {
              RangeValues rv = filter!['price'];
              filtered = filtered.where((p) => p['price'] >= rv.start && p['price'] <= rv.end).toList();
            }
            if (filter!['categories'] != null) {
              List<String> cats = filter!['categories'];
              if (cats.isNotEmpty) {
                 // dummy filter for now
                 // filtered = filtered.where((p) => cats.contains(p['category'])).toList();
              }
            }
          } else {
             if (categoryName != 'All' && categoryName != 'Filtered') {
                filtered = filtered.where((p) => p['category'] == categoryName).toList();
             }
          }

          if (filtered.isEmpty) {
             return const Center(child: Text("No products found."));
          }
          
          return GridView.builder(
            padding: const EdgeInsets.all(20), 
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, 
              crossAxisSpacing: 16, 
              mainAxisSpacing: 16, 
              childAspectRatio: 0.58
            ), 
            itemCount: filtered.length, 
            itemBuilder: (context, index) { 
              return ProductCard(product: filtered[index]); 
            }
          ); 
        }
      )
    ); 
  } 
}
"""
with codecs.open('lib/screens/product/category_products_screen.dart', 'w', 'utf-8') as f:
    f.write(content)
print("CategoryProductsScreen fixed")
