import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

pattern = r"// 4\. Grid View.*?Padding\(\s*padding: const EdgeInsets\.symmetric\(horizontal: 20\),\s*child: ValueListenableBuilder.*?builder: \(context, wishlist, child\) \{\s*if \(wishlist\.isEmpty\).*?return GridView\.builder\(\s*shrinkWrap: true, physics: const NeverScrollableScrollPhysics\(\),\s*gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount\(\s*crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0\.58\s*\),\s*itemCount: wishlist\.length,\s*itemBuilder: \(context, index\) \{\s*final item = wishlist\[index\];\s*return ProductCard\(\s*title: item\['title'\] \?\? '',\s*subtitle: item\['subtitle'\] \?\? '',\s*price: item\['price'\] \?\? '',\s*imageUrl: item\['image'\] \?\? '',\s*rating: '4\.5', reviews: '0', isFav: true\s*\);\s*\}\s*\);\s*\}\s*\),\s*\)"

new_grid = '''// 4. Grid View
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: filteredItems.isEmpty 
                      ? const Padding(
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
                        )
                      : GridView.builder(
                          shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.58
                          ),
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) {
                            final item = filteredItems[index];
                            return ProductCard(
                              title: item['title'] ?? '', 
                              subtitle: item['subtitle'] ?? '', 
                              price: item['price'] ?? '', 
                              imageUrl: item['image'] ?? '', 
                              rating: '4.5', reviews: '0', isFav: true
                            );
                          }
                        ),
                  )'''

content = re.sub(pattern, new_grid, content, flags=re.DOTALL)

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)

print("Regex replace GridView completed")
