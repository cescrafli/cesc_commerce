import 'package:flutter/material.dart';

void main() {
  runApp(const CescCommerceApp());
}

// ----------------------------------------------------------------------
// STATE MANAGEMENT GLOBAL (Sederhana)
// ----------------------------------------------------------------------
final ValueNotifier<List<Map<String, dynamic>>> globalCart = ValueNotifier([]);

void addToCart(String title, String subtitle, String priceStr, String image, BuildContext context) {
  double price = 0.0;
  try { price = double.parse(priceStr.replaceAll('\$', '').trim()); } catch (e) { price = 10.0; }

  final currentCart = List<Map<String, dynamic>>.from(globalCart.value);
  int existingIndex = currentCart.indexWhere((item) => item['title'] == title);
  
  if (existingIndex >= 0) { currentCart[existingIndex]['qty']++; } 
  else { currentCart.add({'title': title, 'subtitle': subtitle, 'price': price, 'qty': 1, 'image': image}); }
  
  globalCart.value = currentCart;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('$title added to cart!'), backgroundColor: const Color(0xFF18C5DF), duration: const Duration(seconds: 1))
  );
}

void updateCartItemQty(int index, int change) {
  final currentCart = List<Map<String, dynamic>>.from(globalCart.value);
  currentCart[index]['qty'] += change;
  if (currentCart[index]['qty'] <= 0) { currentCart.removeAt(index); }
  globalCart.value = currentCart;
}

void removeCartItem(int index) {
  final currentCart = List<Map<String, dynamic>>.from(globalCart.value);
  currentCart.removeAt(index);
  globalCart.value = currentCart;
}

class CescCommerceApp extends StatelessWidget {
  const CescCommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cescrafli',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // WARNA UTAMA DIUBAH KE CYAN SESUAI LOGO BARU
        primaryColor: const Color(0xFF18C5DF),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF18C5DF)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(), 
    );
  }
}

// ----------------------------------------------------------------------
