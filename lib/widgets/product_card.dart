import 'package:flutter/material.dart';
import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';

class ProductCard extends StatelessWidget { 

  final Map<String, dynamic> product;
  final String tag1;
  final String tag2;
  final String oldPrice;

  const ProductCard({super.key, required this.product, this.tag1 = '', this.tag2 = '', this.oldPrice = ''}); 

  

  @override 

  Widget build(BuildContext context) { 
    final priceVal = product['price'];
    final double price = (priceVal is String) ? (double.tryParse(priceVal.replaceAll('\$', '').trim()) ?? 0.0) : (priceVal as num?)?.toDouble() ?? 0.0;

    return GestureDetector(

onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product))); },

      child: Container(

        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)), 

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start, 

          children: [

            Expanded(

              child: Stack(

                children: [

                  ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(20)), child: Image.network(product['image'] ?? '', width: double.infinity, height: double.infinity, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported, size: 60))), 

                  // Favorite Button

                  Positioned(

                    top: 10, right: 10, 

                    child: ValueListenableBuilder<List<Map<String, dynamic>>>(

                      valueListenable: globalWishlist,

                      builder: (context, wishlist, child) {

                        final isFavorite = wishlist.any((item) => item['id'].toString() == product['id'].toString());

                        return GestureDetector(

                          onTap: () => toggleWishlistObj(product, context),

                          child: Container(

                            padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.9), shape: BoxShape.circle), 

                            child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, size: 16, color: isFavorite ? Colors.red : Colors.grey)

                          )

                        );

                      }

                    )

                  ),

                  // Tags

                  Positioned(

                    top: 10, left: 10,

                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        if (tag1.isNotEmpty) Container(margin: const EdgeInsets.only(bottom: 4), padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: tag1.contains('%') ? Theme.of(context).primaryColor : Colors.black87, borderRadius: BorderRadius.circular(6)), child: Text(tag1, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold))),

                        if (tag2.isNotEmpty) Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(6)), child: Text(tag2, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold))),

                      ],

                    ),

                  )

                ]

              )

            ), 

            Padding(

              padding: const EdgeInsets.all(12.0), 

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start, 

                mainAxisSize: MainAxisSize.min,

                children: [

                  Row(

                    children: [

                      Icon(Icons.star, color: Colors.amber.shade500, size: 14), const SizedBox(width: 4),

                      Text((product['rating'] ?? 0.0).toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)), const SizedBox(width: 4),

                      Text('(${product['reviews']?.toString() ?? '0'})', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),

                    ],

                  ),

                  const SizedBox(height: 6),

                  Text(product['title']?.toString() ?? 'Product', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, height: 1.2), maxLines: 2, overflow: TextOverflow.ellipsis), 

                  const SizedBox(height: 2), 

                  Text(product['subtitle']?.toString() ?? '', style: TextStyle(color: Colors.grey.shade500, fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis), 

                  const SizedBox(height: 10), 

                  Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween, 

                    children: [

                      Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Text('\$${price.toStringAsFixed(2)}', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 15)),

                          if (oldPrice.isNotEmpty) Text(oldPrice, style: TextStyle(color: Colors.grey.shade400, decoration: TextDecoration.lineThrough, fontSize: 10)),

                        ],

                      ), 

                      GestureDetector(

                        onTap: () { addToCartObj(product, 1, 'M', 'Default', context); }, 

                        child: Container(

                          padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(8)), 

                          child: const Icon(Icons.add, color: Colors.white, size: 18)

                        )

                      )

                    ]

                  )

                ]

              )

            )

          ]

        )

      )

    ); 

  } 

}
