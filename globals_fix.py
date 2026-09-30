import codecs

with codecs.open('lib/core/globals.dart', 'r', 'utf-8') as f:
    content = f.read()

globals_code = """
final ValueNotifier<List<Map<String, dynamic>>> globalCart = ValueNotifier([]);
final ValueNotifier<List<Map<String, dynamic>>> globalWishlist = ValueNotifier([]);
final ValueNotifier<List<Map<String, dynamic>>> globalAddresses = ValueNotifier([
  {'id': '1', 'title': 'Home Address', 'name': 'Cesc Fabregas', 'phone': '(+1858-555-0192)', 'address': '123 Main Street, Apt 4B, San Diego, CA 92101', 'isDefault': True},
  {'id': '2', 'title': 'Office Address', 'name': 'Cesc Fabregas', 'phone': '(+1858-555-0192)', 'address': '456 Business Park, Suite 200, San Diego, CA 92102', 'isDefault': False}
]);
final ValueNotifier<int> globalSelectedAddressIndex = ValueNotifier(0);
final ValueNotifier<List<Map<String, dynamic>>> globalNotifications = ValueNotifier([
  {'title': 'Order Shipped', 'message': 'Your order #12345 has been shipped', 'time': '2 hours ago', 'isRead': False, 'icon': 0xe3fa},
  {'title': 'Special Offer', 'message': 'Get 20% off on your next purchase', 'time': '5 hours ago', 'isRead': False, 'icon': 0xe3e0},
  {'title': 'Account Update', 'message': 'Your password was changed successfully', 'time': '1 day ago', 'isRead': True, 'icon': 0xe5ce}
]);
"""

content = content.replace("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\n" + globals_code)

with codecs.open('lib/core/globals.dart', 'w', 'utf-8') as f:
    f.write(content.replace('True', 'true').replace('False', 'false'))
    
print("Globals added!")
