import codecs, re

# FIX CART SCREEN
with codecs.open('lib/screens/cart/cart_screen.dart', 'r', 'utf-8') as f:
    cart_content = f.read()

# Undo the bad closing at the very end
if "    );\n      }\n    );\n  }\n}" in cart_content:
    cart_content = cart_content.replace("    );\n      }\n    );\n  }\n}", "  }\n}")

# Properly close ValueListenableBuilder BEFORE _buildEmptyState
if "    );\n      }\n    );\n  }\n\n\n\n  Widget _buildEmptyState" not in cart_content:
    cart_content = re.sub(
        r"    \);\s*\}\s*Widget _buildEmptyState",
        "    );\n      }\n    );\n  }\n\n  Widget _buildEmptyState",
        cart_content
    )

# Fix const Text(tr('...'))
cart_content = cart_content.replace("const Text(tr('checkout')", "Text(tr('checkout')")
cart_content = cart_content.replace("const Text(tr('shopping_cart')", "Text(tr('shopping_cart')")
cart_content = cart_content.replace("const Text(tr('empty_cart')", "Text(tr('empty_cart')")

with codecs.open('lib/screens/cart/cart_screen.dart', 'w', 'utf-8') as f:
    f.write(cart_content)

# FIX FAVORITE SCREEN
with codecs.open('lib/screens/product/favorite_screen.dart', 'r', 'utf-8') as f:
    fav_content = f.read()

# Undo bad closing at very end
if "    );\n      }\n    );\n  }\n}" in fav_content:
    fav_content = fav_content.replace("    );\n      }\n    );\n  }\n}", "  }\n}")

# Where does build method end in FavoriteScreen?
# It has no helper methods! Wait, it has a closing bracket.
# Let's check if it has helper methods. If not, the end of file WAS the build method...
# BUT wait! `error - Expected ';' after this. lib/screens/product/favorite_screen.dart:225:3`
# The file has 225 lines. Let's see what is at the end.
