import codecs, re

with codecs.open('lib/screens/home/home_screen.dart', 'r', 'utf-8') as f:
    content = f.read()

replacement = """ValueListenableBuilder<List<Map<String, dynamic>>>(
                  valueListenable: globalProducts,
                  builder: (context, products, child) {
                    final newArrivals = products.where((p) => p['category'] == 'Shirts' || p['category'] == 'Pants').take(4).toList();
                    return GridView.builder(
                      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.58),
                      itemCount: newArrivals.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: newArrivals[index]);
                      }
                    );
                  }
                )"""

# The GridView.count block
content = re.sub(
    r"GridView\.count\([\s\S]*?children: \[[\s\S]*?ProductCard\(title: 'Botanical Casual Shirt'[\s\S]*?\],[\s\S]*?\),",
    replacement + ",",
    content
)

with codecs.open('lib/screens/home/home_screen.dart', 'w', 'utf-8') as f:
    f.write(content)
print("HomeScreen fixed")
