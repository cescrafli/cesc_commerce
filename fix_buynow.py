import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

# Fix Buy Now in ProductDetailScreen
bad_buy_now = r"""                  onPressed: () {
                    for(int i=0; i<_qty; i++) { addToCart(widget.title, 'Size: ${_sizes[_selectedSizeIndex]}', widget.price, widget.imageUrl, context); }
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => CheckoutScreen(items: globalCart.value)));
                  },"""

good_buy_now = r"""                  onPressed: () {
                    double price = 0.0;
                    try { price = double.parse(widget.price.replaceAll('$', '').trim()); } catch(e) {}
                    
                    final singleItem = {
                      'title': widget.title,
                      'subtitle': 'Size: ${_sizes[_selectedSizeIndex]}',
                      'price': price,
                      'qty': _qty,
                      'image': widget.imageUrl
                    };
                    
                    Navigator.push(context, MaterialPageRoute(builder: (_) => CheckoutScreen(items: [singleItem])));
                  },"""

content = content.replace(bad_buy_now.replace('\r', ''), good_buy_now)
if good_buy_now not in content:
    print("Warning: could not replace exact Buy Now block, using regex")
    content = re.sub(r"onPressed: \(\) \{\s*for\(int i=0; i<_qty; i\+\+\) \{ addToCart\(widget\.title, 'Size: \$\{_sizes\[_selectedSizeIndex\]\}', widget\.price, widget\.imageUrl, context\); \}\s*Navigator\.pop\(context\);\s*Navigator\.push\(context, MaterialPageRoute\(builder: \(_\) => CheckoutScreen\(items: globalCart\.value\)\)\);\s*\},", good_buy_now, content)

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Buy Now logic fixed!")
