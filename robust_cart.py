import codecs

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

# Fix 1: cart loop
old_loop = "for (var item in cartItems) { totalPrice += (item['price'] as double) * (item['qty'] as int); }"
new_loop = '''for (var item in cartItems) { 
                    double p = 0.0;
                    if (item['price'] is String) { p = double.tryParse(item['price'].toString().replaceAll('\\\$', '').trim()) ?? 0.0; } 
                    else if (item['price'] is num) { p = (item['price'] as num).toDouble(); }
                    totalPrice += p * (item['qty'] as int); 
                  }'''

content = content.replace(old_loop, new_loop)

# Fix 2: _buildCartItem definition
old_def = "Widget _buildCartItem(BuildContext context, int index, String title, String subtitle, double price, int qty, String img) {"
new_def = "Widget _buildCartItem(BuildContext context, int index, String title, String subtitle, dynamic priceRaw, int qty, String img) { double price = 0.0; if (priceRaw is String) { price = double.tryParse(priceRaw.toString().replaceAll('\\\$', '').trim()) ?? 0.0; } else if (priceRaw is num) { price = priceRaw.toDouble(); }"

content = content.replace(old_def, new_def)

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)

print("Robust cart parsing injected!")
