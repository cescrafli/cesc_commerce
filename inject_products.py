import codecs, re

with codecs.open('lib/core/globals.dart', 'r', 'utf-8') as f:
    content = f.read()

products_db = """
final ValueNotifier<List<Map<String, dynamic>>> globalProducts = ValueNotifier([
  {'id': 'p1', 'title': 'Classic White T-Shirt', 'subtitle': 'Cotton', 'price': 25.0, 'category': 'Clothes', 'brand': 'Nike', 'image': 'https://picsum.photos/seed/p1/300/400', 'rating': 4.5, 'reviews': 120, 'isPopular': true},
  {'id': 'p2', 'title': 'Black Denim Jacket', 'subtitle': 'Denim', 'price': 75.0, 'category': 'Clothes', 'brand': 'Puma', 'image': 'https://picsum.photos/seed/p2/300/400', 'rating': 4.8, 'reviews': 85, 'isPopular': true},
  {'id': 'p3', 'title': 'Running Sneakers', 'subtitle': 'Sport', 'price': 120.0, 'category': 'Shoes', 'brand': 'Nike', 'image': 'https://picsum.photos/seed/p3/300/400', 'rating': 4.7, 'reviews': 340, 'isPopular': true},
  {'id': 'p4', 'title': 'Leather Backpack', 'subtitle': 'Accessories', 'price': 95.0, 'category': 'Bags', 'brand': 'Adidas', 'image': 'https://picsum.photos/seed/p4/300/400', 'rating': 4.6, 'reviews': 210, 'isPopular': false},
  {'id': 'p5', 'title': 'Summer Floral Dress', 'subtitle': 'Dress', 'price': 45.0, 'category': 'Clothes', 'brand': 'Zara', 'image': 'https://picsum.photos/seed/p5/300/400', 'rating': 4.3, 'reviews': 55, 'isPopular': false},
  {'id': 'p6', 'title': 'Smart Watch Series 7', 'subtitle': 'Electronics', 'price': 399.0, 'category': 'Accessories', 'brand': 'Apple', 'image': 'https://picsum.photos/seed/p6/300/400', 'rating': 4.9, 'reviews': 1500, 'isPopular': true},
  {'id': 'p7', 'title': 'Slim Fit Chinos', 'subtitle': 'Pants', 'price': 40.0, 'category': 'Clothes', 'brand': 'H&M', 'image': 'https://picsum.photos/seed/p7/300/400', 'rating': 4.2, 'reviews': 90, 'isPopular': false},
  {'id': 'p8', 'title': 'Casual Sneakers', 'subtitle': 'Sport', 'price': 65.0, 'category': 'Shoes', 'brand': 'Puma', 'image': 'https://picsum.photos/seed/p8/300/400', 'rating': 4.4, 'reviews': 120, 'isPopular': false},
  {'id': 'p9', 'title': 'Polarized Sunglasses', 'subtitle': 'Eyewear', 'price': 120.0, 'category': 'Accessories', 'brand': 'Ray-Ban', 'image': 'https://picsum.photos/seed/p9/300/400', 'rating': 4.8, 'reviews': 430, 'isPopular': true},
  {'id': 'p10', 'title': 'Travel Duffel Bag', 'subtitle': 'Bags', 'price': 55.0, 'category': 'Bags', 'brand': 'Nike', 'image': 'https://picsum.photos/seed/p10/300/400', 'rating': 4.5, 'reviews': 65, 'isPopular': false},
]);

final ValueNotifier<List<Map<String, dynamic>>> globalOrders = ValueNotifier([]);

void toggleWishlistObj(Map<String, dynamic> product, BuildContext context) {
  final current = List<Map<String, dynamic>>.from(globalWishlist.value);
  final index = current.indexWhere((item) => item['id'] == product['id']);
  if (index >= 0) {
    current.removeAt(index);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Removed from wishlist'), duration: Duration(seconds: 1)));
  } else {
    current.add(product);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to wishlist!'), backgroundColor: Color(0xFF18C5DF), duration: Duration(seconds: 1)));
  }
  globalWishlist.value = current;
}

void addToCartObj(Map<String, dynamic> product, int qty, String size, String color, BuildContext context) {
  final currentCart = List<Map<String, dynamic>>.from(globalCart.value);
  
  int existingIndex = currentCart.indexWhere((item) => item['id'] == product['id'] && item['size'] == size && item['color'] == color);
  if (existingIndex >= 0) { 
    currentCart[existingIndex]['qty'] += qty; 
  } else { 
    currentCart.add({
      'id': product['id'],
      'title': product['title'],
      'subtitle': '${product['subtitle']} | Size: $size | Color: $color',
      'price': product['price'],
      'qty': qty,
      'image': product['image'],
      'size': size,
      'color': color,
    }); 
  }
  globalCart.value = currentCart;
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${product['title']} added to cart!'), backgroundColor: const Color(0xFF18C5DF), duration: const Duration(seconds: 1)));
}
"""

if 'globalProducts' not in content:
    content = content.replace("final ValueNotifier<List<Map<String, dynamic>>> globalCart = ValueNotifier([]);", products_db + "\nfinal ValueNotifier<List<Map<String, dynamic>>> globalCart = ValueNotifier([]);")

with codecs.open('lib/core/globals.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Globals updated!")
