with open('lib/screens/cart/checkout_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()

import_svc = "import 'package:cesc_commerce/core/services/order_service.dart';\nimport 'package:cesc_commerce/core/services/cart_service.dart';\n"
if 'order_service.dart' not in content:
    content = content.replace("import 'package:cesc_commerce/widgets.dart';", "import 'package:cesc_commerce/widgets.dart';\n" + import_svc)

old_press = '''onPressed: () { 
    final currentOrders = List<Map<String, dynamic>>.from(globalOrders.value);
    currentOrders.add({'id': 'ORD-', 'date': DateTime.now().toString(), 'items': List.from(globalCart.value), 'total': total});
    globalOrders.value = currentOrders;
    globalCart.value = []; 
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OrderSuccessScreen())); 
},'''

new_press = '''onPressed: () async {
    final orderData = {
      'items': List.from(globalCart.value),
      'total': total,
      'shippingMethod': _selectedShipping,
    };
    await OrderService().placeOrder(orderData);
    await CartService().clearCart();
    if (context.mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OrderSuccessScreen())); 
    }
},'''

# Fix string interpolation for python
new_press = new_press.replace('\\\$', '$')

content = content.replace(old_press, new_press)

with open('lib/screens/cart/checkout_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed checkout')
