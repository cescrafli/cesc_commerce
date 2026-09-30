import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8', errors='ignore') as f:
    content = f.read()

# 1. Inject calculation in build method
build_method_start = '''  @override
  Widget build(BuildContext context) {'''
build_method_new = '''  @override
  Widget build(BuildContext context) {
    double subtotal = 0.0;
    for (var item in widget.items) {
      double p = 0.0;
      if (item['price'] is String) p = double.tryParse(item['price'].toString().replaceAll('\\$', '').trim()) ?? 0.0;
      else if (item['price'] is num) p = item['price'].toDouble();
      subtotal += p * (item['qty'] as int);
    }
    double discount = subtotal * 0.10;
    double shipping = selectedShipping == 'Standard Eco' ? 0.0 : 6.99;
    double total = subtotal - discount + shipping;
'''
content = content.replace(build_method_start, build_method_new, 1)

# 2. Replace hardcoded "Order Items (2)"
content = content.replace("Text('Order Items (2)',", "Text('Order Items (\)',")

# 3. Replace hardcoded totals
content = re.sub(
    r"Text\('Subtotal',\s*style:\s*TextStyle\(color:\s*Colors.grey.shade500,\s*fontSize:\s*13\)\),\s*const\s*Text\('[\-9.]+',\s*style:\s*TextStyle\(fontWeight:\s*FontWeight.bold,\s*fontSize:\s*13\)\)",
    r"Text('Subtotal', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)), Text('\{subtotal.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))",
    content
)

content = re.sub(
    r"const Text\('FREE',\s*style:\s*TextStyle\(color:\s*Colors.green,\s*fontWeight:\s*FontWeight.bold,\s*fontSize:\s*13\)\)",
    r"Text(shipping == 0 ? 'FREE' : '+\{shipping.toStringAsFixed(2)}', style: TextStyle(color: shipping == 0 ? Colors.green : Colors.black, fontWeight: FontWeight.bold, fontSize: 13))",
    content
)

content = re.sub(
    r"const Text\('-\.50',\s*style:\s*TextStyle\(color:\s*Colors.green,\s*fontWeight:\s*FontWeight.bold,\s*fontSize:\s*13\)\)",
    r"Text('-\{discount.toStringAsFixed(2)}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13))",
    content
)

content = re.sub(
    r"const Text\('\.50',\s*style:\s*TextStyle\(fontWeight:\s*FontWeight.bold,\s*fontSize:\s*22\)\)",
    r"Text('\{total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22))",
    content
)

content = re.sub(
    r"Text\('\.50',\s*style:\s*TextStyle\(color:\s*Colors.white,\s*fontSize:\s*16,\s*fontWeight:\s*FontWeight.bold\)\)",
    r"Text('\{total.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))",
    content
)

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)

print("Replaced checkout totals!")
