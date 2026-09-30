import 'package:flutter/material.dart';
import 'package:cesc_commerce/core/localization.dart';

import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/widgets.dart';

class FavoriteScreen extends StatefulWidget {

  const FavoriteScreen({super.key});



  @override

  State<FavoriteScreen> createState() => _FavoriteScreenState();

}

class _FavoriteScreenState extends State<FavoriteScreen> {
  String _selectedCategory = 'All';

  String _getCategory(Map<String, dynamic> item) {
    return item['category']?.toString() ?? 'Other';
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: globalLanguage,
      builder: (context, lang, _) {
        return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: ValueListenableBuilder<List<Map<String, dynamic>>>(
          valueListenable: globalWishlist,
          builder: (context, wishlist, _) {
            // Count categories
            Map<String, int> catCounts = {'All': wishlist.length};
            for (var item in wishlist) {
              String cat = _getCategory(item);
              catCounts[cat] = (catCounts[cat] ?? 0) + 1;
            }
            
            // Build chips list
            final rawCats = globalWishlist.value.map((item) => item['category']?.toString() ?? 'Other').toSet();
            rawCats.remove('All');
            List<String> activeCats = ['All', ...rawCats.toList()..sort()];

            // Filter items
            List<Map<String, dynamic>> filteredItems = _selectedCategory == 'All' 
                ? wishlist 
                : wishlist.where((item) => (item['category']?.toString() ?? 'Other') == _selectedCategory).toList();

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Navigator.canPop(context) 
                    ? GestureDetector(
                        onTap: () { if (Navigator.canPop(context)) Navigator.pop(context); },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                          child: const Icon(Icons.arrow_back_ios_new, size: 18),
                        ),
                      )
                    : const SizedBox(width: 40),
                        Column(
                          children: [
                            Text(tr('favorites'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text('${wishlist.length} saved items' , style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                          child: const Icon(Icons.more_horiz, size: 20),
                        ),
                      ],
                    ),
                  ),

                  // 2. Chips
                  const SizedBox(height: 10),
                  if (wishlist.isNotEmpty) SizedBox(
                    height: 35,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: activeCats.length,
                      itemBuilder: (context, index) {
                        String cat = activeCats[index];
                        String label = '${cat} (${catCounts[cat]})';
                        bool isSelected = _selectedCategory == cat;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedCategory = cat),
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.black54, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, fontSize: 12)),
                          ),
                        );
                      },
                    ),
                  ),
                  
                  // 3. Sub-header

              Padding(

                padding: const EdgeInsets.all(20),

                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                    Row(

                      children: [

                        Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),

                        const SizedBox(width: 8),

                        Text(tr('all_items_in_stock'), style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),

                      ],

                    ),

                    GestureDetector(
                      onTap: () {
                        if (filteredItems.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(tr('no_items_to_move'))));
                          return;
                        }
                        for (var item in filteredItems) {
                           addToCartObj(item, 1, 'M', 'Default', context, suppressSnackBar: true);
                        }
                        
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${filteredItems.length} items moved to cart')));
                        
                        // Optionally clear wishlist of these items
                        final currentWishlist = List<Map<String, dynamic>>.from(globalWishlist.value);
                        currentWishlist.removeWhere((w) => filteredItems.any((f) => f['id']?.toString() == w['id']?.toString()));
                        globalWishlist.value = currentWishlist;
                      },
                      child: Row(
                        children: [
                          Text(tr('move_all_to_cart'), style: TextStyle(fontSize: 13, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 4),
                          Icon(Icons.arrow_forward_ios, size: 12, color: Theme.of(context).primaryColor),
                        ],
                      ),
                    )

                  ],

                ),

              ),



              // 4. Grid View
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: filteredItems.isEmpty 
                      ? Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Center(
                            child: Column(
                              children: [
                                const Icon(Icons.favorite_border, size: 60, color: Colors.black26),
                                const SizedBox(height: 16),
                                Text(tr('empty_wishlist'), style: TextStyle(fontSize: 16, color: Colors.black54)),
                              ]
                            )
                          )
                        )
                      : GridView.builder(
                          shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.58
                          ),
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) {
                            final item = filteredItems[index];
                            return ProductCard(product: item);
                          }
                        ),
                  ),

              const SizedBox(height: 80),

            ],
          ),
        );
          }
        ),
      ),
    );
      }
    );
  }
}

