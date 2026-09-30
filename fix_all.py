import codecs, re

# 1. FIX LOCALIZATION.DART DUPLICATES
with codecs.open('lib/core/localization.dart', 'r', 'utf-8') as f:
    loc = f.read()

# We need to remove the duplicate 'total' keys. 
# There is likely "'total': 'Total'," and then my new "'total': 'Total:'," or similar.
# Let's just remove the first instance in each block, or specifically the old one.
# old ones: 'total': 'Total', 'total': 'Total', 'total': 'Total', 'total': '??',
loc = loc.replace("'total': 'Total',\n", "")
loc = loc.replace("'total': '??',\n", "")

with codecs.open('lib/core/localization.dart', 'w', 'utf-8') as f:
    f.write(loc)

# 2. FIX CARTSCREEN (start_shopping)
with codecs.open('lib/screens/cart/cart_screen.dart', 'r', 'utf-8') as f:
    cart = f.read()
# It says: Text(tr('start_shopping'), style: TextStyle... but it's probably inside a const Center or similar
# Let's search for "const Center(child: Text(tr('start_shopping')" or similar.
cart = cart.replace("const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 18), SizedBox(width: 8), Text(tr('start_shopping')", "Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 18), const SizedBox(width: 8), Text(tr('start_shopping')")
# Wait, let's just blindly remove const before widgets containing Text(tr
cart = re.sub(r"const\s+Center\(\s*child:\s*Text\(\s*tr\('start_shopping'\)", r"Center(child: Text(tr('start_shopping')", cart)
cart = re.sub(r"const\s+Row\([^\[]*\[[^\]]*tr\('start_shopping'\)", lambda m: m.group(0).replace('const Row', 'Row').replace('Icon(', 'const Icon(').replace('SizedBox(', 'const SizedBox('), cart)

with codecs.open('lib/screens/cart/cart_screen.dart', 'w', 'utf-8') as f:
    f.write(cart)

# 3. FIX PRODUCT DETAIL (buy_now, verified_buyer)
with codecs.open('lib/screens/product/product_detail_screen.dart', 'r', 'utf-8') as f:
    prod = f.read()
# line 112: const Row(... Text(tr('buy_now') ...)
prod = prod.replace("const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.flash_on, color: Colors.white, size: 18), SizedBox(width: 4), Text(tr('buy_now')", "Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.flash_on, color: Colors.white, size: 18), const SizedBox(width: 4), Text(tr('buy_now')")
# line 547: Row(children: const [Icon(...), SizedBox(...), Text(tr('verified_buyer') ...)])
prod = prod.replace("Row(children: const [Icon(Icons.verified, color: Colors.green, size: 12), SizedBox(width: 4), Text(tr('verified_buyer')", "Row(children: [const Icon(Icons.verified, color: Colors.green, size: 12), const SizedBox(width: 4), Text(tr('verified_buyer')")

with codecs.open('lib/screens/product/product_detail_screen.dart', 'w', 'utf-8') as f:
    f.write(prod)

# 4. FIX FAVORITESCREEN (SnackBar)
with codecs.open('lib/screens/product/favorite_screen.dart', 'r', 'utf-8') as f:
    fav = f.read()
fav = fav.replace("const SnackBar(content: Text(tr('no_items_to_move')))", "SnackBar(content: Text(tr('no_items_to_move')))")
fav = fav.replace("const SnackBar(content: Text(tr('moved_all_to_cart')))", "SnackBar(content: Text(tr('moved_all_to_cart')))")

with codecs.open('lib/screens/product/favorite_screen.dart', 'w', 'utf-8') as f:
    f.write(fav)

# 5. FIX MYORDERS SCREEN (Center)
with codecs.open('lib/screens/profile/my_orders_screen.dart', 'r', 'utf-8') as f:
    orders = f.read()
orders = orders.replace("const Center(child: Text(tr('no_orders_yet')", "Center(child: Text(tr('no_orders_yet')")

with codecs.open('lib/screens/profile/my_orders_screen.dart', 'w', 'utf-8') as f:
    f.write(orders)

print("All fixes applied")
