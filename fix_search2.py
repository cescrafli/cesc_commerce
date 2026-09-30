import re
with open('lib/screens/home/search_screen.dart', 'r', encoding='utf-8', errors='replace') as f:
    content = f.read()

content = content.replace('''                  return ProductCard(
                    product: results[index],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailScreen(product: results[index]),
                      ),
                    ),
                  );''', '''                  return ProductCard(
                    product: results[index],
                  );''')

with open('lib/screens/home/search_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed search_screen.dart ProductCard')
