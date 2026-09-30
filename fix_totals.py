import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

# Replace Subtotal
content = re.sub(
    r"Text\('Subtotal',\s*style:\s*TextStyle\(color:\s*Colors\.grey\.shade500,\s*fontSize:\s*13\)\),\s*const\s*Text\('(.+?)',\s*style:\s*TextStyle\(fontWeight:\s*FontWeight\.bold,\s*fontSize:\s*13\)\)",
    r"Text('Subtotal', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)), Text('\{subtotal.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))",
    content
)

# Replace Delivery Fee
content = re.sub(
    r"Text\('Delivery Fee',\s*style:\s*TextStyle\(color:\s*Colors\.grey\.shade500,\s*fontSize:\s*13\)\),\s*const\s*Text\('FREE',\s*style:\s*TextStyle\(color:\s*Colors\.green,\s*fontWeight:\s*FontWeight\.bold,\s*fontSize:\s*13\)\)",
    r"Text('Delivery Fee', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)), Text(shipping == 0 ? 'FREE' : '+\{shipping.toStringAsFixed(2)}', style: TextStyle(color: shipping == 0 ? Colors.green : Colors.black, fontWeight: FontWeight.bold, fontSize: 13))",
    content
)

# Replace Discount
content = re.sub(
    r"const\s*Text\('-\\\$[0-9.]+',\s*style:\s*TextStyle\(color:\s*Colors\.green,\s*fontWeight:\s*FontWeight\.bold,\s*fontSize:\s*13\)\)",
    r"Text('-\{discount.toStringAsFixed(2)}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13))",
    content
)

# Replace Total Amount
content = re.sub(
    r"Text\('Total Amount',\s*style:\s*TextStyle\(fontWeight:\s*FontWeight\.bold,\s*fontSize:\s*16\)\),\s*const\s*SizedBox\(height:\s*2\),\s*Text\('Includes all local taxes & duties',\s*style:\s*TextStyle\(color:\s*Colors\.grey\.shade400,\s*fontSize:\s*10\)\),\s*],\s*\),\s*const\s*Text\('(.+?)',\s*style:\s*TextStyle\(fontWeight:\s*FontWeight\.bold,\s*fontSize:\s*22\)\)",
    r"Text('Total Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), const SizedBox(height: 2), Text('Includes all local taxes & duties', style: TextStyle(color: Colors.grey.shade400, fontSize: 10)), ], ), Text('\{total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22))",
    content
)

# Replace Bottom Action Bar total
content = re.sub(
    r"Text\('(.+?)',\s*style:\s*TextStyle\(color:\s*Colors\.white,\s*fontSize:\s*16,\s*fontWeight:\s*FontWeight\.bold\)\),\s*SizedBox\(width:\s*8\),\s*Icon\(Icons\.arrow_forward,\s*color:\s*Colors\.white,\s*size:\s*18\)",
    r"Text('\{total.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)), const SizedBox(width: 8), const Icon(Icons.arrow_forward, color: Colors.white, size: 18)",
    content
)

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)

print("Done checkout totals!")
