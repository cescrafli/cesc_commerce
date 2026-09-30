import 'package:cesc_commerce/core/globals.dart';

class CartService {
  Future<void> clearCart() async {
    await Future.delayed(const Duration(milliseconds: 300));
    globalCart.value = [];
  }
}
