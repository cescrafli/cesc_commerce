import 'package:cesc_commerce/core/globals.dart';

class ProductService {
  Future<List<Map<String, dynamic>>> getProducts({String? category}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (category != null && category.toLowerCase() != 'all') {
      return globalProducts.value.where((p) => p['category'].toString().toLowerCase() == category.toLowerCase()).toList();
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
    if (!categories.contains('All')) categories.insert(0, 'All');
    return categories;
  }

  Future<void> submitReview(String productId, double rating, String text) async {
    await Future.delayed(const Duration(milliseconds: 800));
    // In a real app, this would send to API.
  }
}
