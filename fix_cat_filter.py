import codecs, re

with codecs.open('lib/screens/product/category_products_screen.dart', 'r', 'utf-8') as f:
    content = f.read()

# Update constructor
content = content.replace("final String categoryName; const CategoryProductsScreen({super.key, required this.categoryName});", "final String categoryName; final Map<String, dynamic>? filter; const CategoryProductsScreen({super.key, required this.categoryName, this.filter});")

# Update build method logic
new_logic = """final filtered = products.where((p) {
            if (categoryName != 'All' && categoryName != 'Filtered') {
              if (p['category'] != categoryName) return false;
            }
            if (filter != null) {
              if (filter!['price'] != null) {
                final range = filter!['price'] as RangeValues;
                if (p['price'] < range.start || p['price'] > range.end) return false;
              }
              if (filter!['categories'] != null && (filter!['categories'] as List).isNotEmpty) {
                final cats = filter!['categories'] as List;
                if (!cats.contains(p['category'])) return false;
              }
              if (filter!['brands'] != null && (filter!['brands'] as List).isNotEmpty) {
                final brands = filter!['brands'] as List;
                if (!brands.contains(p['brand'])) return false;
              }
            }
            return true;
          }).toList();"""
content = re.sub(r"final filtered = categoryName == 'All' \? products : products\.where\(\(p\) => p\['category'\] == categoryName\)\.toList\(\);", new_logic, content)

with codecs.open('lib/screens/product/category_products_screen.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Done")
