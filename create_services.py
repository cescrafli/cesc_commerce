import os

services_dir = 'lib/core/services'
os.makedirs(services_dir, exist_ok=True)

# ProductService
with open(os.path.join(services_dir, 'product_service.dart'), 'w', encoding='utf-8') as f:
    f.write('''import 'package:cesc_commerce/core/globals.dart';

class ProductService {
  Future<List<Map<String, dynamic>>> getProducts({String? category}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (category != null && category != 'All') {
      return globalProducts.value.where((p) => p['category'] == category).toList();
    }
    return globalProducts.value;
  }

  Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final q = query.toLowerCase();
    return globalProducts.value.where((p) => p['title'].toString().toLowerCase().contains(q) || p['category'].toString().toLowerCase().contains(q)).toList();
  }

  Future<List<String>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final categories = globalProducts.value.map((p) => p['category'].toString()).toSet().toList();
    categories.insert(0, 'All');
    return categories;
  }

  Future<void> submitReview(String productId, double rating, String text) async {
    await Future.delayed(const Duration(milliseconds: 800));
    // In a real app, this would send to API.
  }
}
''')

# CartService
with open(os.path.join(services_dir, 'cart_service.dart'), 'w', encoding='utf-8') as f:
    f.write('''import 'package:cesc_commerce/core/globals.dart';

class CartService {
  Future<List<Map<String, dynamic>>> getCart() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return globalCart.value;
  }

  Future<void> addToCart(Map<String, dynamic> item) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final current = List<Map<String, dynamic>>.from(globalCart.value);
    
    final existingIndex = current.indexWhere((cartItem) => 
      cartItem['title'] == item['title'] && 
      cartItem['color'] == item['color'] && 
      cartItem['size'] == item['size']
    );

    if (existingIndex >= 0) {
      current[existingIndex]['qty'] = (current[existingIndex]['qty'] ?? 1) + (item['qty'] ?? 1);
    } else {
      current.add(item);
    }
    globalCart.value = current;
  }

  Future<void> updateQuantity(int index, int newQty) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final current = List<Map<String, dynamic>>.from(globalCart.value);
    if (newQty > 0) {
      current[index]['qty'] = newQty;
    } else {
      current.removeAt(index);
    }
    globalCart.value = current;
  }
  
  Future<void> removeFromCart(int index) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final current = List<Map<String, dynamic>>.from(globalCart.value);
    current.removeAt(index);
    globalCart.value = current;
  }

  Future<void> clearCart() async {
    await Future.delayed(const Duration(milliseconds: 300));
    globalCart.value = [];
  }
}
''')

# OrderService
with open(os.path.join(services_dir, 'order_service.dart'), 'w', encoding='utf-8') as f:
    f.write('''import 'package:cesc_commerce/core/globals.dart';

class OrderService {
  Future<String> placeOrder(Map<String, dynamic> orderData) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network
    final orderId = 'ORD-\';
    
    final newOrder = {
      ...orderData,
      'id': orderId,
      'date': DateTime.now().toIso8601String(),
      'status': 'Pending'
    };
    
    final currentOrders = List<Map<String, dynamic>>.from(globalOrders.value);
    currentOrders.insert(0, newOrder);
    globalOrders.value = currentOrders;
    
    return orderId;
  }

  Future<List<Map<String, dynamic>>> getOrders({String? status}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (status != null && status != 'All') {
      return globalOrders.value.where((o) => o['status'] == status).toList();
    }
    return globalOrders.value;
  }
}
''')

# AddressService
with open(os.path.join(services_dir, 'address_service.dart'), 'w', encoding='utf-8') as f:
    f.write('''import 'package:cesc_commerce/core/globals.dart';

class AddressService {
  Future<List<Map<String, dynamic>>> getAddresses() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return globalAddresses.value;
  }

  Future<void> addAddress(Map<String, dynamic> address) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final current = List<Map<String, dynamic>>.from(globalAddresses.value);
    current.add(address);
    globalAddresses.value = current;
  }

  Future<void> updateAddress(int index, Map<String, dynamic> address) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final current = List<Map<String, dynamic>>.from(globalAddresses.value);
    if (index >= 0 && index < current.length) {
      current[index] = address;
      globalAddresses.value = current;
    }
  }
}
''')

# UserService
with open(os.path.join(services_dir, 'user_service.dart'), 'w', encoding='utf-8') as f:
    f.write('''
class UserService {
  // Mock current user profile data
  static Map<String, dynamic> mockProfile = {
    'name': 'Cesc Fabregas',
    'email': 'cesc.fabregas@clubmail.com',
    'phone': '(555) 382-9014',
    'avatar': 'https://i.pravatar.cc/150?img=11',
    'dob': 'May 4, 1987',
    'gender': 'Male'
  };

  Future<Map<String, dynamic>> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return mockProfile;
  }

  Future<void> updateProfile(Map<String, dynamic> newData) async {
    await Future.delayed(const Duration(milliseconds: 800));
    mockProfile = {...mockProfile, ...newData};
  }
}
''')

# NotificationService
with open(os.path.join(services_dir, 'notification_service.dart'), 'w', encoding='utf-8') as f:
    f.write('''import 'package:cesc_commerce/core/globals.dart';

class NotificationService {
  Future<List<Map<String, dynamic>>> getNotifications() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return globalNotifications.value;
  }

  Future<void> markAsRead(int index) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final current = List<Map<String, dynamic>>.from(globalNotifications.value);
    if (index >= 0 && index < current.length) {
      current[index]['isRead'] = true;
      globalNotifications.value = current;
    }
  }

  Future<void> markAllAsRead() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final current = List<Map<String, dynamic>>.from(globalNotifications.value);
    for (var n in current) {
      n['isRead'] = true;
    }
    globalNotifications.value = current;
  }
}
''')

print('Created services')
