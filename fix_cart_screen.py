import codecs, re

with codecs.open('lib/screens/cart/cart_screen.dart', 'r', 'utf-8') as f:
    content = f.read()

replacement = """ValueListenableBuilder<List<Map<String, dynamic>>>(
              valueListenable: globalProducts,
              builder: (context, products, child) {
                final suggested = products.take(3).toList();
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: suggested.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    return SizedBox(width: 170, child: ProductCard(product: suggested[index]));
                  }
                );
              }
            )"""

content = re.sub(
    r"ListView\([\s\S]*?children: \[[\s\S]*?ProductCard\(title: 'Cargo Utility Pants'[\s\S]*?\],[\s\S]*?\)",
    replacement,
    content
)

with codecs.open('lib/screens/cart/cart_screen.dart', 'w', 'utf-8') as f:
    f.write(content)
print("CartScreen fixed")
