import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

# 1. Empty the globalWishlist initial value to [] instead of containing the dummy item.
pattern_wishlist = r"final ValueNotifier<List<Map<String, dynamic>>> globalWishlist = ValueNotifier\(\[\s*\{'title': 'Basic Eco-Cotton T-Shirt'.*?\n\]\);"
content = re.sub(pattern_wishlist, "final ValueNotifier<List<Map<String, dynamic>>> globalWishlist = ValueNotifier([]);", content, flags=re.DOTALL)

# 2. Rewrite FavoriteScreen GridView
pattern_grid = r"// 4\. Grid View\s*Padding\(\s*padding: const EdgeInsets\.symmetric\(horizontal: 20\),\s*child: GridView\.count\(\s*crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics\(\),\s*crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0\.58,\s*children: \[.*?\]\,\s*\),\s*\),"

new_grid = '''// 4. Grid View
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ValueListenableBuilder<List<Map<String, dynamic>>>(
                  valueListenable: globalWishlist,
                  builder: (context, wishlist, child) {
                    if (wishlist.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(Icons.favorite_border, size: 60, color: Colors.black26),
                              SizedBox(height: 16),
                              Text('Your wishlist is empty', style: TextStyle(fontSize: 16, color: Colors.black54)),
                            ]
                          )
                        )
                      );
                    }
                    return GridView.builder(
                      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.58
                      ),
                      itemCount: wishlist.length,
                      itemBuilder: (context, index) {
                        final item = wishlist[index];
                        return ProductCard(
                          title: item['title'] ?? '', 
                          subtitle: item['subtitle'] ?? '', 
                          price: item['price'] ?? '', 
                          imageUrl: item['image'] ?? '', 
                          rating: '4.5', reviews: '0', isFav: true
                        );
                      }
                    );
                  }
                ),
              ),'''

content = re.sub(pattern_grid, new_grid, content, flags=re.DOTALL)


with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Updated FavoriteScreen logic")

