import codecs

with codecs.open('lib/widgets/product_card.dart', 'r', 'utf-8') as f:
    content = f.read()
content = content.replace("item['product['title']'] == product['title']", "item['id'] == product['id']")
with codecs.open('lib/widgets/product_card.dart', 'w', 'utf-8') as f:
    f.write(content)

with codecs.open('lib/widgets/filter_bottom_sheet.dart', 'r', 'utf-8') as f:
    fcontent = f.read()

# Let's see the context around line 138 in filter_bottom_sheet
# Because it's hard to guess the missing bracket, let me just fix the 'Apply Filter' button I added earlier
# In fix_filter.py, I did:
# r"onTap: () => Navigator.pop(context, {'price': _priceRange, 'categories': selectedCategories}),\n                     child: Container(\n                         height: 50,\n                         decoration: BoxDecoration(color: const Color(0xFF0F8A9E), borderRadius: BorderRadius.circular(16)),\n                         child: Row(\n                           mainAxisAlignment: MainAxisAlignment.center,\n                           children: [\n                              const Text('Apply Filter'"
# Wait, I didn't add the closing `]` and `)`!
# My regex replaced up to `const Text('Apply Filter'`, but I didn't close it if the original had more things.
# I'll just rewrite the button manually.
