import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';

class CategoryItem extends StatelessWidget { 
  final String title; final String iconUrl; final bool isSelected; final VoidCallback? onTap;
  const CategoryItem({super.key, required this.title, required this.iconUrl, required this.isSelected, this.onTap}); 

  @override 
  Widget build(BuildContext context) { 
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8), 
      child: GestureDetector(
        onTap: onTap ?? () { Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryProductsScreen(categoryName: title))); }, 
        child: Column(
          children: [
            // Gambar sekarang sudah memiliki lingkaran putih dan bayangan dari desain asli
            Container(
              height: 70, width: 70, 
              decoration: isSelected ? BoxDecoration(
                shape: BoxShape.circle, 
                border: Border.all(color: Theme.of(context).primaryColor, width: 2)
              ) : null,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: iconUrl.startsWith('http') 
                    ? Image.network(iconUrl, fit: BoxFit.cover) 
                    : Image.asset(iconUrl, fit: BoxFit.cover),
              )
            ), 
            const SizedBox(height: 8), 
            Text(title, style: TextStyle(fontSize: 13, fontWeight: isSelected ? FontWeight.bold : FontWeight.w500, color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade600))
          ]
        )
      )
    ); 
  } 
}
