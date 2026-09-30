import 'package:flutter/material.dart';

import 'package:cesc_commerce/core/globals.dart';
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
          
          if (categoryName != 'All' && categoryName != 'Filtered') {
             filtered = filtered.where((p) => p['category'].toString().toLowerCase() == categoryName.toLowerCase()).toList();
          }

          if (filter != null) {
            if (filter!['price'] != null) {
              if (filter!['price'] is! RangeValues) return const SizedBox();
              RangeValues rv = filter!['price'] as RangeValues;
              filtered = filtered.where((p) {
                final double price = (p['price'] is String) ? double.tryParse(p['price'].replaceAll('\$', '')) ?? 0.0 : (p['price'] as num?)?.toDouble() ?? 0.0;
                return price >= rv.start && price <= rv.end;
              }).toList();
            }
            if (filter!['categories'] != null) {
              List<String> cats = (filter!['categories'] as Iterable? ?? []).map((e) => e.toString()).toList();
              if (cats.isNotEmpty) {
                 filtered = filtered.where((p) => cats.map((c) => c.toLowerCase()).contains((p['category']?.toString() ?? '').toLowerCase())).toList();
              }
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
