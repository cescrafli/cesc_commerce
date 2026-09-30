import codecs, re

# Fix CategoryProductsScreen
with codecs.open('lib/screens/product/category_products_screen.dart', 'r', 'utf-8') as f:
    cat_content = f.read()

# Filter globalProducts by category Name!
new_body = """body: ValueListenableBuilder(
        valueListenable: globalProducts,
        builder: (context, List<Map<String, dynamic>> products, child) {
          final filtered = categoryName == 'All' ? products : products.where((p) => p['category'] == categoryName).toList();
          return GridView.builder(
            padding: const EdgeInsets.all(20), 
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.58), 
            itemCount: filtered.length, 
            itemBuilder: (context, index) { 
              return ProductCard(product: filtered[index]);
            }
          );
        }
      )"""
cat_content = re.sub(r'body: GridView\.builder\([^;]+\)\)', new_body + ')', cat_content)

with codecs.open('lib/screens/product/category_products_screen.dart', 'w', 'utf-8') as f:
    f.write(cat_content)

# Fix HomeScreen
with codecs.open('lib/screens/home/home_screen.dart', 'r', 'utf-8') as f:
    home_content = f.read()

# Home has two lists: Popular and New. 
# Popular: ProductCard(title: 'Item $index'...)
home_content = re.sub(r'itemCount: 4,\s*itemBuilder: \(context, index\) \{\s*return ProductCard\([^;]+\);\s*\}', r"""
itemCount: globalProducts.value.where((p) => p['isPopular'] == True).length,
itemBuilder: (context, index) {
  final popular = globalProducts.value.where((p) => p['isPopular'] == True).toList();
  return Padding(padding: const EdgeInsets.only(right: 16), child: SizedBox(width: 160, child: ProductCard(product: popular[index])));
}
""".replace('True', 'true'), home_content)

# New arrivals (grid)
home_content = re.sub(r'itemCount: 4,\s*itemBuilder: \(context, index\) \{\s*return ProductCard\([^;]+\);\s*\}\)', r"""
itemCount: 4,
itemBuilder: (context, index) {
  final newArrivals = globalProducts.value.where((p) => p['isPopular'] == False).toList();
  return ProductCard(product: newArrivals[index]);
})
""".replace('False', 'false'), home_content)

# Also fix the cart badge in HomeScreen
home_content = re.sub(r'Container\(padding: const EdgeInsets\.all\(4\), decoration: const BoxDecoration\(color: Colors\.red, shape: BoxShape\.circle\), child: const Text\(\'3\', style: TextStyle\(color: Colors\.white, fontSize: 10, fontWeight: FontWeight\.bold\)\)\)',
                      r'''ValueListenableBuilder(
                          valueListenable: globalCart,
                          builder: (context, cart, child) {
                            if (cart.isEmpty) return const SizedBox();
                            return Container(padding: const EdgeInsets.all(4), decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle), child: Text('${cart.length}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)));
                          }
                        )''', home_content)

with codecs.open('lib/screens/home/home_screen.dart', 'w', 'utf-8') as f:
    f.write(home_content)

print("Home & Category fixed!")
