import codecs

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    lines = f.readlines()

replace_str = "replaceAll(" + chr(39) + chr(92) + chr(36) + chr(39) + ", " + chr(39) + chr(39) + ")"

for i, line in enumerate(lines):
    if "replaceAll(" in line and "is String" in line:
        lines[i] = "                    if (item['price'] is String) { p = double.tryParse(item['price'].toString()." + replace_str + ".trim()) ?? 0.0; } \n"
    if "_buildCartItem" in line and "is String" in line:
        lines[i] = "  Widget _buildCartItem(BuildContext context, int index, String title, String subtitle, dynamic priceRaw, int qty, String img) { double price = 0.0; if (priceRaw is String) { price = double.tryParse(priceRaw.toString()." + replace_str + ".trim()) ?? 0.0; } else if (priceRaw is num) { price = priceRaw.toDouble(); }\n"

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.writelines(lines)
