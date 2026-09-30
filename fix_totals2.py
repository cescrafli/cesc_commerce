import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

# I will replace `$${.toStringAsFixed(2)}` with `\$${var.toStringAsFixed(2)}`
content = content.replace("Text('\\$${.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))", "Text('\\$${subtotal.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))")
content = content.replace("Text('\\$${.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22))", "Text('\\$${total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22))")
content = content.replace("Text('\\$${.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))", "Text('\\$${total.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))")
content = content.replace("Text('-\\$${.toStringAsFixed(2)}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13))", "Text('-\\$${discount.toStringAsFixed(2)}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13))")
content = content.replace("Text(shipping == 0 ? 'FREE' : '+\\$${.toStringAsFixed(2)}', style: TextStyle(color: shipping == 0 ? Colors.green : Colors.black, fontWeight: FontWeight.bold, fontSize: 13))", "Text(shipping == 0 ? 'FREE' : '+\\$${shipping.toStringAsFixed(2)}', style: TextStyle(color: shipping == 0 ? Colors.green : Colors.black, fontWeight: FontWeight.bold, fontSize: 13))")

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)

print("Fixed totals with proper variables!")
