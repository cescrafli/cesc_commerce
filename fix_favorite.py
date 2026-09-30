import codecs, re

with codecs.open('lib/screens/product/favorite_screen.dart', 'r', 'utf-8') as f:
    content = f.read()

content = re.sub(
    r"return ProductCard\([\s\S]*?title: item\['title'\][\s\S]*?isFav: true[\s\S]*?\);",
    "return ProductCard(product: item);",
    content
)

with codecs.open('lib/screens/product/favorite_screen.dart', 'w', 'utf-8') as f:
    f.write(content)
print("FavoriteScreen fixed")
