import codecs, re

with codecs.open('lib/screens/product/favorite_screen.dart', 'r', 'utf-8') as f:
    content = f.read()

# Update Add All to Cart logic
# find currentCart.add({...});
# Replace it with addToCartObj logic
content = re.sub(
    r"currentCart\.add\(\{[\s\S]+?\}\);",
    r"currentCart.add({'id': item['id'], 'title': item['title'], 'subtitle': item['subtitle'], 'price': item['price'], 'qty': 1, 'image': item['image'], 'size': 'M', 'color': 'Default'});",
    content
)

# Update clear wishlist logic to use 'id'
content = content.replace("f['title'] == w['title']", "f['id'] == w['id']")

# Update ProductCard(title: item['title']...) to ProductCard(product: item)
content = re.sub(
    r"ProductCard\(\s*title: item\['title'\],\s*subtitle: item\['subtitle'\],\s*price: item\['price'\],\s*oldPrice: '',\s*imageUrl: item\['image'\] \?\? item\['imageUrl'\] \?\? 'https://picsum\.photos/200',\s*rating: '4\.5',\s*reviews: '23',\s*isFav: true,\s*\)",
    "ProductCard(product: item)",
    content
)

with codecs.open('lib/screens/product/favorite_screen.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Done")
