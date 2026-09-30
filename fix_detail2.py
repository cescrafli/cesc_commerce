import codecs, re
with codecs.open('lib/screens/product/product_detail_screen.dart', 'r', 'utf-8') as f:
    content = f.read()

# Replace constructor
content = re.sub(
    r"final String title;\s*final String price;\s*final String imageUrl;\s*const ProductDetailScreen\(\{super\.key, required this\.title, required this\.price, required this\.imageUrl\}\);",
    "final Map<String, dynamic> product;\n  const ProductDetailScreen({super.key, required this.product});",
    content
)

# Use product in build
replacements = {
    "widget.title": "widget.product['title']",
    "widget.price": "'\\$${widget.product['price'].toStringAsFixed(2)}'",
    "widget.imageUrl": "widget.product['image']",
}
for old, new in replacements.items():
    content = content.replace(old, new)

# Fix addToCart
content = re.sub(r"addToCart\([^)]+\)", "addToCartObj(widget.product, 1, _sizes[_selectedSizeIndex], _colors[_selectedColorIndex].toString(), context)", content)

# Fix fakeItem BuyNow
content = re.sub(r"final Map<String, dynamic> fakeItem = \{[^}]+\};", 
                 "final Map<String, dynamic> fakeItem = {'id': widget.product['id'], 'title': widget.product['title'], 'subtitle': 'Size: ${_sizes[_selectedSizeIndex]}', 'price': widget.product['price'], 'qty': 1, 'image': widget.product['image']};", content)

with codecs.open('lib/screens/product/product_detail_screen.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Done")
