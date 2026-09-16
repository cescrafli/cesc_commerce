import re

with open('lib/main.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Inject globalWishlist
global_vars = '''final ValueNotifier<List<Map<String, dynamic>>> globalCart = ValueNotifier([]);
final ValueNotifier<List<Map<String, dynamic>>> globalWishlist = ValueNotifier([
  {'title': 'Basic Eco-Cotton T-Shirt', 'subtitle': '100% Organic Cotton', 'price': '\.00', 'image': 'https://picsum.photos/seed/101/300/400'}
]);

void toggleWishlist(String title, String subtitle, String price, String imageUrl, BuildContext context) {
  final current = List<Map<String, dynamic>>.from(globalWishlist.value);
  final index = current.indexWhere((item) => item['title'] == title);
  if (index >= 0) {
    current.removeAt(index);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Removed from wishlist'), duration: Duration(seconds: 1)));
  } else {
    current.add({'title': title, 'subtitle': subtitle, 'price': price, 'image': imageUrl});
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to wishlist!'), backgroundColor: Color(0xFF18C5DF), duration: Duration(seconds: 1)));
  }
  globalWishlist.value = current;
}'''

content = content.replace('final ValueNotifier<List<Map<String, dynamic>>> globalCart = ValueNotifier([]);', global_vars)

# 2. Update ProductCard's Favorite Button
old_fav = '''                  // Favorite Button
                  Positioned(
                    top: 10, right: 10, 
                    child: Container(
                      padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), shape: BoxShape.circle), 
                      child: Icon(isFav ? Icons.favorite : Icons.favorite_border, size: 16, color: isFav ? Colors.red : Colors.grey)
                    )
                  ),'''

new_fav = '''                  // Favorite Button
                  Positioned(
                    top: 10, right: 10, 
                    child: ValueListenableBuilder<List<Map<String, dynamic>>>(
                      valueListenable: globalWishlist,
                      builder: (context, wishlist, child) {
                        final isFavorite = wishlist.any((item) => item['title'] == title);
                        return GestureDetector(
                          onTap: () => toggleWishlist(title, subtitle, price, imageUrl, context),
                          child: Container(
                            padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.9), shape: BoxShape.circle), 
                            child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, size: 16, color: isFavorite ? Colors.red : Colors.grey)
                          )
                        );
                      }
                    )
                  ),'''

if old_fav in content:
    content = content.replace(old_fav, new_fav)
else:
    # Try regex if exact string mismatch
    pattern = r'// Favorite Button\s*Positioned\(\s*top: 10, right: 10,\s*child: Container\(\s*padding: const EdgeInsets\.all\(6\), decoration: BoxDecoration\(color: Colors\.white\.withOpacity\(0\.9\), shape: BoxShape\.circle\),\s*child: Icon\(isFav \? Icons\.favorite : Icons\.favorite_border, size: 16, color: isFav \? Colors\.red : Colors\.grey\)\s*\)\s*\),'
    content = re.sub(pattern, new_fav, content)


with open('lib/main.dart', 'w', encoding='utf-8') as f:
    f.write(content)

print("Injected globalWishlist and updated ProductCard")
