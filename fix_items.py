import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

# I need to fix the items mapping block:
bad_block = r"""...widget.items.map((item) {
                      double itemPrice = 0.0;
                      if (item['price'] is String) {
                        itemPrice = double.tryParse(item['price'].toString().replaceAll('\$', '').trim()) ?? 0.0;
                      } else if (item['price'] is num) {
                        itemPrice = item['price'].toDouble();
                      }
                      return _buildOrderItemCard(Icons.shopping_bag, item['title'] ?? 'Product', 'Qty: ', '\$');
                    }).toList(),"""

good_block = r"""...widget.items.map((item) {
                      double itemPrice = 0.0;
                      if (item['price'] is String) {
                        itemPrice = double.tryParse(item['price'].toString().replaceAll('\$', '').trim()) ?? 0.0;
                      } else if (item['price'] is num) {
                        itemPrice = item['price'].toDouble();
                      }
                      return _buildOrderItemCard(Icons.shopping_bag, item['title'] ?? 'Product', 'Qty: ${item['qty']}', '\$${(itemPrice * (item['qty'] as int)).toStringAsFixed(2)}');
                    }).toList(),"""

content = content.replace(bad_block.replace('\r', ''), good_block)

# Try replacing without replacing \r just in case
if good_block not in content:
    print("Could not find the exact string. Using a looser regex...")
    bad_regex = r"\.\.\.widget\.items\.map\(\(item\) \{.*?return _buildOrderItemCard\(Icons\.shopping_bag, item\['title'\] \?\? 'Product', 'Qty: ', '\\\$'\);\s*\}\)\.toList\(\),"
    content = re.sub(bad_regex, good_block, content, flags=re.DOTALL)

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)

print("Fixed checkout items list!")
