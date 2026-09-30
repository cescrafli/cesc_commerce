import 'package:flutter/material.dart';


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
    globalWishlist.value = current;
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Removed from wishlist'), duration: Duration(seconds: 1)));
  } else {
    current.add(product);
    globalWishlist.value = current;
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to wishlist!'), backgroundColor: Color(0xFF18C5DF), duration: Duration(seconds: 1)));
  }
}

void addToCartObj(Map<String, dynamic> product, int qty, String size, String color, BuildContext context, {bool suppressSnackBar = false}) {
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
  if (!suppressSnackBar) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${product['title']} added to cart!'), backgroundColor: const Color(0xFF18C5DF), duration: const Duration(seconds: 1)));
  }
}

final ValueNotifier<List<Map<String, dynamic>>> globalCart = ValueNotifier([]);
final ValueNotifier<List<Map<String, dynamic>>> globalWishlist = ValueNotifier([]);
final ValueNotifier<List<Map<String, dynamic>>> globalAddresses = ValueNotifier([
  {
    'id': '1',
    'title': 'Home',
    'name': 'Cesc Fabregas',
    'phone': '+1 619 555 0101',
    'address': '123 Main Street, Apt 4B, San Diego, CA 92101',
    'isDefault': true,
    'street': '123 Main Street',
    'city': 'San Diego',
    'zip': '92101',
    'state': 'CA',
    'apt': '',
    'instructions': ''
  },
  {
    'id': '2',
    'title': 'Office Address',
    'name': 'Cesc Fabregas',
    'phone': '(+1858-555-0192)',
    'address': '456 Business Park, Suite 200, San Diego, CA 92102',
    'isDefault': false,
    'street': '456 Business Park',
    'city': 'San Diego',
    'zip': '92102',
    'state': 'CA',
    'apt': 'Suite 200',
    'instructions': ''
  }
]);
final ValueNotifier<int> globalSelectedAddressIndex = ValueNotifier(0);
final ValueNotifier<List<Map<String, dynamic>>> globalSavedCards = ValueNotifier([
  {'id': 'card_1', 'name': 'Mastercard', 'last4': '8831', 'expiry': '12/26', 'type': 'mastercard', 'title': 'Mastercard ending in 8831', 'isDefault': true, 'subtitle': 'Expires 12/26 • Credit Card'}, 
  {'id': 'card_2', 'name': 'Visa', 'last4': '4242', 'expiry': '08/28', 'type': 'visa', 'title': 'Visa ending in 4242', 'isDefault': false, 'subtitle': 'Expires 08/28 • Debit Card'}
]);
final ValueNotifier<Map<String, dynamic>?> globalUser = ValueNotifier(null);

final ValueNotifier<List<Map<String, dynamic>>> globalNotifications = ValueNotifier([
  {'id': 'notif_1', 'type': 'order', 'title': 'Order Shipped', 'body': 'Your order #12345 has been shipped', 'time': '2 hours ago', 'isRead': false, 'icon': 0xe3fa},
  {'id': 'notif_2', 'type': 'promo', 'title': 'Special Offer', 'body': 'Get 20% off on your next purchase', 'time': '5 hours ago', 'isRead': false, 'icon': 0xe3e0},
  {'id': 'notif_3', 'type': 'account', 'title': 'Account Update', 'body': 'Your password was changed successfully', 'time': '1 day ago', 'isRead': false, 'icon': 0xe5ce}
]);






void updateCartItemQty(int index, int change) {

  final currentCart = List<Map<String, dynamic>>.from(globalCart.value);
  if (index < 0 || index >= currentCart.length) return;

  currentCart[index]['qty'] += change;

  if (currentCart[index]['qty'] <= 0) { currentCart.removeAt(index); }

  globalCart.value = currentCart;

}

void removeCartItem(int index) {

  final currentCart = List<Map<String, dynamic>>.from(globalCart.value);
  if (index < 0 || index >= currentCart.length) return;

  currentCart.removeAt(index);

  globalCart.value = currentCart;

}
ValueNotifier<ThemeMode> globalThemeMode = ValueNotifier(ThemeMode.light);
