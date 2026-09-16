import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'models.dart';

// Firebase Auth Provider
final authProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

// Cart Provider
class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(Product product) {
    final existingIndex = state.indexWhere((item) => item.product.id == product.id);
    if (existingIndex >= 0) {
      final newState = [...state];
      newState[existingIndex].quantity++;
      state = newState;
    } else {
      state = [...state, CartItem(product: product)];
    }
  }

  void updateQuantity(String productId, int change) {
    final existingIndex = state.indexWhere((item) => item.product.id == productId);
    if (existingIndex >= 0) {
      final newState = [...state];
      final newQty = newState[existingIndex].quantity + change;
      if (newQty > 0) {
        newState[existingIndex].quantity = newQty;
        state = newState;
      } else {
        newState.removeAt(existingIndex);
        state = newState;
      }
    }
  }

  void clearCart() {
    state = [];
  }
  
  double get totalAmount {
    return state.fold(0.0, (total, item) => total + (item.product.price * item.quantity));
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});
