import codecs
import re

with codecs.open('lib/screens/cart/checkout_screen.dart', 'r', 'utf-8') as f:
    checkout = f.read()

# Fix shipping, total etc
if 'double shipping =' not in checkout:
    # Need to find build method and add variables
    checkout = checkout.replace('Widget build(BuildContext context) {\n', 'Widget build(BuildContext context) {\n    double subtotal = 0;\n    for(var i in widget.items) { subtotal += i["price"] * i["qty"]; }\n    double discount = 5.0;\n    double shipping = 0;\n    double total = subtotal - discount + shipping;\n')

with codecs.open('lib/screens/cart/checkout_screen.dart', 'w', 'utf-8') as f:
    f.write(checkout)

# Fix product detail
with codecs.open('lib/screens/product/product_detail_screen.dart', 'r', 'utf-8') as f:
    prod = f.read()
prod = prod.replace("'Size: ${_sizes[_selectedSizeIndex]}'", "'Size: \\${_sizes[_selectedSizeIndex]}'")
with codecs.open('lib/screens/product/product_detail_screen.dart', 'w', 'utf-8') as f:
    f.write(prod)
