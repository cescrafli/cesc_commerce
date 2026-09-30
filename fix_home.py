import re

with open('lib/screens/home/home_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()

import_svc = "import 'package:cesc_commerce/core/services/product_service.dart';\n"
if 'product_service.dart' not in content:
    content = content.replace("import 'package:cesc_commerce/widgets.dart';", "import 'package:cesc_commerce/widgets.dart';\n" + import_svc)

old_list = '''ValueListenableBuilder<List<Map<String, dynamic>>>(

                  valueListenable: globalProducts,

                  builder: (context, products, child) {

                    final filtered = products.where((p) => p['category'].toString().toLowerCase().contains(_selectedCategory.toLowerCase()) || _selectedCategory == 'All').toList();

                    

                    return Column(

                      children: [

                        // Product Grid

                        GridView.builder(

                          shrinkWrap: true,

                          physics: const NeverScrollableScrollPhysics(),

                          itemCount: filtered.length,

                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 16, mainAxisSpacing: 16),

                          itemBuilder: (context, index) {

                            final p = filtered[index];

                            return ProductCard(product: p, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: p))));

                          }

                        ),

                        const SizedBox(height: 30),

                        // Banner

                        Container(

                          width: double.infinity,

                          padding: const EdgeInsets.all(20),

                          decoration: BoxDecoration(color: const Color(0xFF00B4D8), borderRadius: BorderRadius.circular(16)),

                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [

                              const Text('Member Exclusive', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 12)),

                              const SizedBox(height: 8),

                              const Text('Get 15% OFF\\non your first order', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18, height: 1.2)),

                              const SizedBox(height: 12),

                              ElevatedButton(

                                onPressed: () {},

                                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF00B4D8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),

                                child: const Text('Claim Now', style: TextStyle(fontWeight: FontWeight.bold)),

                              )

                            ]

                          )

                        )

                      ]

                    );

                  }

                )'''

new_list = '''FutureBuilder<List<Map<String, dynamic>>>(
                  future: ProductService().getProducts(category: _selectedCategory == 'All' ? null : _selectedCategory),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: Padding(padding: EdgeInsets.all(40), child: CircularProgressIndicator()));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Padding(padding: EdgeInsets.all(40), child: Text('No products found.')));
                    }
                    
                    final filtered = snapshot.data!;
                    
                    return Column(
                      children: [
                        // Product Grid
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filtered.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 16, mainAxisSpacing: 16),
                          itemBuilder: (context, index) {
                            final p = filtered[index];
                            return ProductCard(product: p, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: p))));
                          }
                        ),
                        const SizedBox(height: 30),
                        // Banner
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(color: const Color(0xFF00B4D8), borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Member Exclusive', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 12)),
                              const SizedBox(height: 8),
                              const Text('Get 15% OFF\\non your first order', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18, height: 1.2)),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF00B4D8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                child: const Text('Claim Now', style: TextStyle(fontWeight: FontWeight.bold)),
                              )
                            ]
                          )
                        )
                      ]
                    );
                  }
                )'''

content = content.replace(old_list, new_list)

# Also fix the Category tap to trigger rebuild (setState)
old_cat_tap = '''GestureDetector(

                            onTap: () => setState(() => _selectedCategory = cat),'''
new_cat_tap = '''GestureDetector(
                            onTap: () => setState(() => _selectedCategory = cat),'''

with open('lib/screens/home/home_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed home screen')
