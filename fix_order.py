import codecs, re

with codecs.open('lib/screens/cart/checkout_screen.dart', 'r', 'utf-8') as f:
    content = f.read()

# Add to globalOrders
new_onpressed = """onPressed: () { 
    final currentOrders = List<Map<String, dynamic>>.from(globalOrders.value);
    currentOrders.add({'id': 'ORD-${DateTime.now().millisecondsSinceEpoch}', 'date': DateTime.now().toString(), 'items': List.from(globalCart.value), 'total': total});
    globalOrders.value = currentOrders;
    globalCart.value = []; 
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OrderSuccessScreen())); 
},"""
content = re.sub(r"onPressed: \(\) \{ globalCart\.value = \[\]; Navigator\.pushReplacement\(context, MaterialPageRoute\(builder: \(\_\) => const OrderSuccessScreen\(\)\)\); \},", new_onpressed, content)

with codecs.open('lib/screens/cart/checkout_screen.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Done")
