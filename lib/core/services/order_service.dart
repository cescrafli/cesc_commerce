import 'package:cesc_commerce/core/globals.dart';

class OrderService {
  Future<String> placeOrder(Map<String, dynamic> orderData) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network
    final orderId = 'ORD-${DateTime.now().millisecondsSinceEpoch}';
    
    final newOrder = {
      ...orderData,
      'id': orderId,
      'date': DateTime.now().toIso8601String(),
      'status': 'Pending',
      'courier': 'Standard Express',
      'trackingNumber': 'TRK-${DateTime.now().millisecondsSinceEpoch}',
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

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final current = List<Map<String, dynamic>>.from(globalOrders.value);
    final idx = current.indexWhere((o) => o['id'] == orderId);
    if (idx != -1) {
      current[idx] = {...current[idx], 'status': newStatus};
      globalOrders.value = current;
    }
  }
}
