import re

with open('lib/screens/home/home_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()

old_block = '''                    final newArrivals = products.where((p) => p['category'] == 'Shirts' || p['category'] == 'Pants').take(4).toList();
                    return GridView.builder(
                      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.58),
                      itemCount: categoryProducts != null && categoryProducts.isNotEmpty ? categoryProducts.length : (products.length > 4 ? 4 : products.length),
                      itemBuilder: (context, index) {
                        return ProductCard(product: categoryProducts != null && categoryProducts.isNotEmpty ? categoryProducts[index] : products[index]);
                      }
                    );'''
new_block = '''                    final filtered = products.where((p) => p['category'].toString().toLowerCase().contains(_selectedCategory.toLowerCase())).toList();
                    final displayProducts = filtered.isNotEmpty ? filtered : products.take(4).toList();
                    return GridView.builder(
                      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.58),
                      itemCount: displayProducts.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: displayProducts[index]);
                      }
                    );'''
content = content.replace(old_block, new_block)

with open('lib/screens/home/home_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
