import codecs, re

with codecs.open('lib/widgets/product_card.dart', 'r', 'utf-8') as f:
    content = f.read()

# Replace fields
content = re.sub(
    r"final String title;.*this\.isFav = false\}\);",
    "final Map<String, dynamic> product;\n\n  const ProductCard({super.key, required this.product});",
    content,
    flags=re.DOTALL
)

# Replace usage of fields inside build
replacements = {
    "imageUrl": "product['image']",
    "title": "product['title']",
    "subtitle": "product['subtitle']",
    "rating": "product['rating'].toString()",
    "reviews": "product['reviews'].toString()",
    "price": "'\\$${product['price'].toStringAsFixed(2)}'",
}

for old, new in replacements.items():
    content = re.sub(r"\b" + old + r"\b", new, content)

# Remove the old toggleWishlist
content = re.sub(
    r"toggleWishlist\(product\['title'\], product\['subtitle'\], '\$?\\$\$\{product\['price'\]\.toStringAsFixed\(2\)\}', product\['image'\], context\)",
    "toggleWishlistObj(product, context)",
    content
)

# Wishlist check dynamically
content = content.replace("product['isFav']", "(globalWishlist.value.any((item) => item['id'] == product['id']))")

# Navigation logic (ProductDetailScreen needs to accept Map too)
content = re.sub(
    r"MaterialPageRoute\(builder: \(context\) => ProductDetailScreen\(title: product\['title'\], subtitle: product\['subtitle'\], price: '\$?\\$\$\{product\['price'\]\.toStringAsFixed\(2\)\}', imageUrl: product\['image'\]\)\)",
    "MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product))",
    content
)

with codecs.open('lib/widgets/product_card.dart', 'w', 'utf-8') as f:
    f.write(content)

print("ProductCard updated!")
