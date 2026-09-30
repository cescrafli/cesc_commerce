import codecs, re

with codecs.open('lib/widgets/promo_carousel.dart', 'r', 'utf-8') as f:
    content = f.read()

new_nav = "Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: {'id': 'promo_${index}', 'title': promo['title'], 'subtitle': 'Promo Deal', 'price': 10.0, 'category': 'Promo', 'brand': 'Promo', 'image': promo['image'], 'rating': 5.0, 'reviews': 99})));"
content = re.sub(r"Navigator\.push\(context, MaterialPageRoute\(builder: \(\_\) => ProductDetailScreen\([^)]+\)\)\);", new_nav, content)

with codecs.open('lib/widgets/promo_carousel.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Done")
