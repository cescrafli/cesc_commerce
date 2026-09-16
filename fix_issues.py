import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

# Fix 1: PromoCarousel Spacer overflow
pattern_spacer = r"const Spacer\(\),"
replacement_spacer = "const SizedBox(height: 10),"
if "const Spacer()," in content:
    content = content.replace("const Spacer(),", "const SizedBox(height: 10),")

# Fix 2: Move All to Cart button
pattern_move = r"Row\(\s*children: \[\s*Text\('Move All to Cart', style: TextStyle\(fontSize: 13, color: Theme\.of\(context\)\.primaryColor, fontWeight: FontWeight\.bold\)\),\s*const SizedBox\(width: 4\),\s*Icon\(Icons\.arrow_forward_ios, size: 12, color: Theme\.of\(context\)\.primaryColor\),\s*\],\s*\)"

replacement_move = '''GestureDetector(
                      onTap: () {
                        if (filteredItems.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No items to move')));
                          return;
                        }
                        final currentCart = List<Map<String, dynamic>>.from(globalCart.value);
                        for (var item in filteredItems) {
                           currentCart.add({
                             'title': item['title'],
                             'subtitle': item['subtitle'],
                             'price': item['price'],
                             'image': item['image'] ?? item['imageUrl'] ?? 'https://picsum.photos/200',
                             'qty': 1,
                           });
                        }
                        globalCart.value = currentCart;
                        
                        // Optionally clear wishlist of these items
                        final currentWishlist = List<Map<String, dynamic>>.from(globalWishlist.value);
                        currentWishlist.removeWhere((w) => filteredItems.any((f) => f['title'] == w['title']));
                        globalWishlist.value = currentWishlist;

                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Moved all to Cart!')));
                      },
                      child: Row(
                        children: [
                          Text('Move All to Cart', style: TextStyle(fontSize: 13, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 4),
                          Icon(Icons.arrow_forward_ios, size: 12, color: Theme.of(context).primaryColor),
                        ],
                      ),
                    )'''

content = re.sub(pattern_move, replacement_move, content, flags=re.DOTALL)

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)

print("Fixes applied successfully")
